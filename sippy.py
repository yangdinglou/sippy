#!/usr/bin/env python

from popper.util import Settings, print_prog_score
from popper.loop import learn_solution

if __name__ == '__main__':
    settings = Settings(cmd_line=True)
    prog, score, stats, cons = learn_solution(settings)
    if prog != None:
        print_prog_score(prog, score, cons, settings.head_types)
    else:
        print('NO SOLUTION')
    if settings.show_stats:
        stats.show()
