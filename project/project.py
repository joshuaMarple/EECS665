import fileinput
import string
import re

for i, line in enumerate(fileinput.input()):
    print i, line
    if i == 0:
        first_state = int(re.split("[{}]", line)[1])
        print first_state
    if i == 1:
        print re.split("[{}]", line)
        final_states = [int(x) for x in re.split("[{}]", line)[1].split(",")]
        print final_states
    if i == 2:
        total_states = re.split(":", line)
        print total_states
    if i == 3:
        state_changes = re.split("\s+", line)
        print state_changes



