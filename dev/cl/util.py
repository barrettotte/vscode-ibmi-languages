# copy contents from https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/clfinder/finder30.htm into ops.txt
# ordered in reverse so commands like WRKLIB don't get matched before WRKLIBPDM
i = 0
opgroups = []
with open('ops.txt', 'r') as f:
    ops = []
    for line in f:
        ops.append(line.strip().split(' ')[0])
        i += 1
        if i == 100:
            opgroups.append('{"name": "keyword.other.cl", "match": "(?i)\\\\b(' + '|'.join(sorted(ops, reverse=True)) + ')\\\\b"}')
            ops = []
            i = 0
with open('regex.json', 'w') as f:
    f.write('[' + (',\n'.join(sorted(opgroups, reverse=True))) + ']')