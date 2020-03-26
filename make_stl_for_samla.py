#!/bin/python3
import argparse
import shutil
import subprocess
import sys
from loguru import logger


def SamlaSizeFormat(v):
    try:
        if int(v) in [5, 11, 22]:
            return int(v)
        raise argparse.ArgumentTypeError("Samla size must be 5, 11, or 22")
    except ValueError:
        raise argparse.ArgumentTypeError("Samla size must be 5, 11, or 22")


def PositiveIntBelow10(v):
    try:
        if int(v) in range(1, 11):
            return int(v)
        raise argparse.ArgumentTypeError("Value must be between [1-10]")
    except ValueError:
        raise argparse.ArgumentTypeError("Value must be between [1-10]")


def parse_args(args):
    """
    Parse command line parameters

    :param args: command line parameters as list of strings
    :return: command line parameters as :obj:`argparse.Namespace`
    """
    parser = argparse.ArgumentParser()
    parser.add_argument('-s', '--size', dest='samla_size', help='SAMLA Size, 5 or 11 or 22', required=True,
                        type=SamlaSizeFormat)
    parser.add_argument('-l', '--layers', dest='layers', help='Number of layers (default 3)', required=True,
                        type=PositiveIntBelow10)
    parser.add_argument('-c', '--columns', dest='columns', help='Number of columns (default 2)', default=2,
                        type=PositiveIntBelow10)
    parser.add_argument('-r', '--rows', dest='rows', help='Number of rows (default 2)', default=2,
                        type=PositiveIntBelow10)
    parser.add_argument('-w', '--walls', dest='walls', help='Walls in mm (default 1.4)', default=1.4, type=float)
    parser.add_argument('-b', '--bottom', dest='bottom', help='Bottom in mm (default 0.8)', default=.8, type=float)
    parser.add_argument('-o', '--only_layer', dest='only_layer', help='Generate only layer x', type=PositiveIntBelow10)
    parser.add_argument('--resolution', dest='resolution', help='Resolution of the model', default=50,
                        type=int)

    return parser.parse_args(args)


def generate_stl(openscad_bin_path, samla_size, total_layers, wanted_layer, cols, rows, wall_mm, bottom_mm, resolution):
    samla_scad_files = {
        5: 'IKEA_Samla_5l_Inserts.scad',
        11: 'IKEA_Samla_11l_Inserts.scad',
        22: 'IKEA_Samla_22l_Inserts.scad'
    }

    parameters = dict(samla_size=samla_size, wanted_layer=wanted_layer, total_layers=total_layers, cols=cols, rows=rows,
                      wall=wall_mm, bottom=bottom_mm, res=resolution)

    openscad_cmd = [openscad_bin_path, '-o',
                    'IKEA_Samla_{samla_size}l_Inserts_{cols}x{rows}_{wanted_layer}_of_{total_layers}.stl'.format(**parameters),
                    '-D', "Active_Layer={wanted_layer};Layers={total_layers};Cell_Columns={cols};Cell_Rows={rows};"
                    "Resolution={res};Wall_Thickness={wall};Bottom_Thickness={bottom}".format(**parameters),
                    samla_scad_files[samla_size]]

    logger.info('Generating STL file layer {wanted_layer} for samla {samla_size} liters with {cols} columns and {rows} rows'
                .format(**parameters))
    logger.debug(' '.join(openscad_cmd))

    openscad = subprocess.Popen(openscad_cmd, stdout=subprocess.PIPE)
    output = openscad.communicate()[0].decode()
    if output:
        logger.error('Result of {0} should be empty but is not: {1}'.format(openscad_cmd, output))


def main(args):
    args_parsed = parse_args(args)

    if shutil.which('openscad') is not None:
        cmd = 'openscad'
    else:
        cmd = '/usr/bin/openscad'

    logger.info('Be patient it can be long to generate, around 45 seconds per generated layer')
    if args_parsed.only_layer and args_parsed.only_layer <= args_parsed.layers:
        generate_stl(openscad_bin_path=cmd, samla_size=args_parsed.samla_size, total_layers=args_parsed.layers,
                     wanted_layer=args_parsed.only_layer, cols=args_parsed.columns, rows=args_parsed.rows,
                     wall_mm=args_parsed.walls, bottom_mm=args_parsed.bottom, resolution=args_parsed.resolution)

    else:
        for layer in range(1, args_parsed.layers+1):
            generate_stl(openscad_bin_path=cmd, samla_size=args_parsed.samla_size, total_layers=args_parsed.layers,
                         wanted_layer=layer, cols=args_parsed.columns, rows=args_parsed.rows,
                         wall_mm=args_parsed.walls, bottom_mm=args_parsed.bottom, resolution=args_parsed.resolution)


if __name__ == '__main__':
    main(sys.argv[1:])
