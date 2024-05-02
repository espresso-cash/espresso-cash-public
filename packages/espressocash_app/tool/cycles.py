#!/usr/bin/env python

"""
dot_find_cycles.py - uses Pydot and NetworkX to find cycles in a dot file directed graph.

Very helpful for Puppet stuff.

By Jason Antman <jason@jasonantman.com> 2012.

Free for all use, provided that you send any changes you make back to me, update the changelog, and keep this comment intact.

REQUIREMENTS:
Python
python-networkx - <http://networkx.lanl.gov/>
graphviz-python - <http://www.graphviz.org/>
pydot - <http://code.google.com/p/pydot/>
pydotplus - <http://pydotplus.readthedocs.io/>

To install requirements:

    pip install networkx graphviz pydot pydotplus

Last Test Requirement Versions:

decorator==4.0.10
graphviz==0.5.1
networkx==1.11
pydot==1.2.2
pydotplus==2.0.2
pyparsing==2.1.9

USAGE:
dot_find_cycles.py /path/to/file.dot

The canonical source of this script can always be found from:
<http://blog.jasonantman.com/2012/03/python-script-to-find-dependency-cycles-in-graphviz-dot-files/>

CHANGELOG:
2018-05-23 Nikolaus Wittenstein <nikolaus.wittenstein@gmail.com>:
  - add Python 3 support

2017-04-20 Frank Kusters <frank.kusters@sioux.eu>:
  - added support for stdin
  - add option for only showing shortest cycles

2016-09-24 Jason Antman <jason@jasonantman.com>:
  - update docs to clarify the below

2016-09-24 jrk07 <https://github.com/jrk07>:
  - add pydotplus and fix read_dot import to work with modern networkx versions

2012-03-28 Jason Antman <jason@jasonantman.com>:
  - initial script creation
"""

import argparse
import sys
from os import R_OK, access, path

import networkx as nx
from networkx.drawing.nx_pydot import read_dot


def main():
    parser = argparse.ArgumentParser(description="Finds cycles in dot file graphs, such as those from Puppet. "
                                     "By Jason Antman <http://blog.jasonantman.com>")
    parser.add_argument('dotfile', metavar='DOTFILE', nargs='?', type=argparse.FileType('r'), default=sys.stdin,
                        help="the dotfile to process. Uses standard input if argument is '-' or not present")
    parser.add_argument("--only-shortest", action='store_true',
                        help="only show the shortest cycles. Example: if both A->C and A->B->C exist, only show the former. "
                        "This vastly reduces the amount of output when analysing dependency issues.")
    parser.add_argument("--print-labels", action='store_true',
                        help="print the node labels instead of their ids.")
    args = parser.parse_args()

    # read in the specified file, create a networkx DiGraph
    G = nx.DiGraph(read_dot(args.dotfile))

    C = nx.simple_cycles(G)
    if args.only_shortest:
        C = remove_super_cycles(C)

    if args.print_labels:
        C = extract_node_labels(C, G)

    for i in C:
        # append the first node again so that the cycle is complete
        i.append(i[0])
        print(" -> ".join(i))

    if len(C) != 0:
        sys.exit(1)


def remove_super_cycles(cycle_list):
    # sorting by length makes the search easier, because shorter cycles cannot be supercycles of longer ones
    cycle_list = sorted(cycle_list, key=len)
    forward_index = 0
    while forward_index < len(cycle_list):
        backward_index = len(cycle_list) - 1
        while backward_index > forward_index:
            # when comparing two cycles, remove all elements that are not in the shortest one
            filtered_list = [x for x in cycle_list[backward_index]
                             if x in cycle_list[forward_index]]
            # double the cycle length, to account for cycles shifted over the end of the list
            full_cycle = filtered_list + filtered_list
            # find the matching start position
            while full_cycle and full_cycle[0] != cycle_list[forward_index][0]:
                del full_cycle[0]
            # matching start position found, now compare the rest
            if cycle_list[forward_index] == full_cycle[:len(cycle_list[forward_index])]:
                # cycle matches, remove supercycle from end result
                del cycle_list[backward_index]
            backward_index = backward_index - 1
        forward_index = forward_index + 1
    return cycle_list


def extract_node_labels(C, G):
    C_labels = []
    for cycle in C:
        cycle_labels = []
        for node_id in cycle:
            cycle_labels.append(G.nodes[node_id]['label'].replace('"', ''))

        C_labels.append(cycle_labels)
    return C_labels


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        pass  # eat CTRL+C so it won't show an exception
