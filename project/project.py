import fileinput
import string
import re
from collections import OrderedDict
import sys

write = sys.stdout.write

# parser

states = {}

for i, line in enumerate(fileinput.input()):
    if i == 0:
        first_state = int(re.split("[{}]", line)[1])
    elif i == 1:
        final_states = [int(x) for x in re.split("[{}]", line)[1].split(",")]
    elif i == 2:
        total_states = int(re.split(":", line)[1])
    elif i == 3:
        state_changes = re.split("\s+", line)
        for j in state_changes:
            if j in ['', 'State']:
                state_changes.remove(j)
        states = {k : {j : [] for j in state_changes} for k in range(1, total_states + 1)}

    else:
        line = re.split("\s+", line)
        cur_num = line[0]
        line.remove(cur_num)
        cur_num = int(cur_num)
        for moves, char in zip(line, state_changes):
            moves = moves.strip('{}')
            if moves != '':
                states[cur_num][char] = eval('[' + moves + ']')

def return_valid_states(state, char):
    answer = []
    for i in states[state][char]:
        answer.append(i)
        for j in return_epsilon_moves(i):
            answer.append(j)
    for i in return_epsilon_moves(state):
        for j in return_valid_states(i, char):
            answer.append(j)
    return answer

def return_valid_states_sans_e_closure(state, char):
    answer = []
    for i in states[state][char]:
        answer.append(i)
    for i in return_epsilon_moves(state):
        for j in return_valid_states_sans_e_closure(i, char):
            answer.append(j)
    return answer


def return_epsilon_moves(state):
    answer = []
    for i in states[state]['E']:
        answer.append(i)
        for j in return_epsilon_moves(i):
            answer.append(j)
    return answer


Dtran = {1: {i:'' for i in state_changes}}
Dstates = OrderedDict()
first_moves = frozenset([first_state] + return_epsilon_moves(first_state))
Dstates[first_moves] = False
write("E-closure(IO) = {")
write(", ".join(repr (e) for e in first_moves))
write("} = 1\n\n")
tran_final_states = []

while(not all(Dstates.values())):
    unmarked = next(i for i, v in enumerate(Dstates.values()) if v == False)
    cur_state = Dstates.keys()[unmarked]
    Dstates[cur_state] = True
    write("Mark %s\n" % (unmarked + 1))
    for i in state_changes:
        if i != 'E':
            moves = frozenset(sum(map(lambda x: return_valid_states(x, i), cur_state), []))
            moves_sans_e = frozenset(sum(map(lambda x: return_valid_states_sans_e_closure(x, i), cur_state), []))
            if moves != frozenset([]):
                if moves not in Dstates.keys():

                    Dstates[moves] = False
                    Dtran[len(Dtran) + 1] = {j : '' for j in state_changes}
                    if any(e in final_states for e in moves):
                        tran_final_states.append(len(Dtran))
                Dtran[unmarked + 1][i] = Dstates.keys().index(moves) + 1
                write("{%s}" % (', '.join(repr(e) for e in sorted(list(cur_state)))))
                write(" --%s--> " % i)
                write("{%s}\n" % (', '.join(repr(e) for e in sorted(list(moves_sans_e)))))
                write("E-closure{%s} = {%s} = %s\n" % (
                    (', '.join(repr(e) for e in sorted(list(moves_sans_e)))),
                    (', '.join(repr(e) for e in sorted(list(moves)))),
                    Dstates.keys().index(moves) + 1))
    write('\n')

write("Initial State: {%s}\n" % first_state)
write("Final States: {%s}\n" % (', '.join(repr(e) for e in sorted(tran_final_states))))

write("%s" % ("State  "))
for i in state_changes:
    if i != 'E':
        write("%s%s" % (i, ''.join(' ' for e in range(0, 7 - len(i)))))
write("\n")
for i in Dtran:
    write("%s%s" % (i,''.join(' ' for e in range(0, 7-len(str(i))))))
    for j in Dtran[i]:
        if j != 'E':
            tmp = '{' + str(Dtran[i][j]) + '}'
            write("%s%s" % (tmp, ''.join(' ' for e in range(0, 7 - len(tmp)))))
    write("\n")
