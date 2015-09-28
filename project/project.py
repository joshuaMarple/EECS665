import fileinput
import string
import re


# parser

states = {}

for i, line in enumerate(fileinput.input()):
    print i, line
    if i == 0:
        first_state = int(re.split("[{}]", line)[1])
        print first_state
    elif i == 1:
        print re.split("[{}]", line)
        final_states = [int(x) for x in re.split("[{}]", line)[1].split(",")]
        print final_states
    elif i == 2:
        total_states = int(re.split(":", line)[1])
        print total_states
    elif i == 3:
        state_changes = re.split("\s+", line)
        for j in state_changes:
            if j in ['', 'State']:
                state_changes.remove(j)
        print state_changes
        states = {k : {j : [] for j in state_changes} for k in range(1, total_states + 1)}
        print states

    else:
        line = re.split("\s+", line)
        cur_num = line[0]
        line.remove(cur_num)
        cur_num = int(cur_num)
        for moves, char in zip(line, state_changes):
            moves = moves.strip('{}')
            if moves != '':
                states[cur_num][char] = eval('[' + moves + ']')
        print line

print states


