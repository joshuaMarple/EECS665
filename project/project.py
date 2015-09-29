import fileinput
import string
import re
from collections import OrderedDict

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

def return_epsilon_moves(state):
    answer = []
    for i in states[state]['E']:
        answer.append(i)
        for j in return_epsilon_moves(i):
            answer.append(j)
    return answer


Dtran = {1: {i:'' for i in state_changes}}
Dstates = OrderedDict()
Dstates[frozenset([first_state] + return_epsilon_moves(first_state))] = False

while(not all(Dstates.values())):
    unmarked = next(i for i, v in enumerate(Dstates.values()) if v == False)
    cur_state = Dstates.keys()[unmarked]
    Dstates[cur_state] = True
    for i in state_changes:
        if i != 'E':
            moves = frozenset(sum(map(lambda x: return_valid_states(x, i), cur_state), []))
            if moves != frozenset([]):
                if moves not in Dstates.keys():
                    Dstates[moves] = False
                    Dtran[len(Dtran) + 1] = {j : '' for j in state_changes}
                Dtran[unmarked + 1][i] = Dstates.keys().index(moves) + 1

print Dstates
print Dtran
