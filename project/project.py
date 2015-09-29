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

new_states = {}

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

state_lookup = {}

state_lookup[frozenset([first_state] + return_epsilon_moves(first_state))] = 1
print state_lookup
new_states = {1: {i:'' for i in state_changes}}
counter = 1

Dstates = {1: False}
while(not all(Dstates.values()):
    unmarked = next(i for i, v in enumerate(Dstates.values()) if v == False)
    for i in state_changes:
        if i != 'E':
            print "char: ", i
            print "new_states:", new_states[counter]
            valid_states = frozenset(sum(map(lambda x: return_valid_states(x, i), state_lookup.keys()[counter]), []))
            if valid_states not in state_lookup:
                print "valid states:", i, "," , valid_states
                state_lookup[valid_states] = len(new_states)
            else:
                new_states
    counter += 1
    if counter > len(new_states):
        break


print return_epsilon_moves(7)
print return_valid_states(3, 'b')
print sorted(list(set(sum(map(lambda x: return_valid_states(x, 'b'), [3]), []))))
