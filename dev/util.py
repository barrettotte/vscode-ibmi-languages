# take list of opcodes, reverse it, and build regex

ops = []
with open('sql/keywords.txt', 'r') as f:
    for line in f:
        ops.append(line.strip())
with open('sql/regex.json', 'w') as f:
    f.write('"' + ('|'.join(sorted(ops, reverse=True))) + '"')