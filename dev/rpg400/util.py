# take list of opcodes, reverse it, and build regex

ops = []
with open('ops.txt', 'r') as f:
    for line in f:
        ops.append(line.strip())
with open('regex.json', 'w') as f:
    f.write('"' + ('|'.join(sorted(ops, reverse=True))) + '"')