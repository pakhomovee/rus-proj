def getRule(s):
    if (s.find('р_ст') != -1 or s.find('р_щ') != -1):
        return 12
    if (s.find('г_р') != -1):
        return 2
    if (s.find('з_р') != -1):
        return 3
    if (s.find('к_с') != -1):
        return 4
    if (s.find('кл_н') != -1):
        return 5
    if (s.find('л_г') != -1 or s.find('л_ж') != -1):
        return 6
    if (s.find('м_к') != -1):
        return 7
    if (s.find('пл_в') != -1):
        return 8
    if (s.find('р_вн') != -1):
        return 9
    if (s.find('ск_к') != -1 or s.find('ск_ч') != -1):
        return 10
    if (s.find('тв_р') != -1):
        return 11
    return 1

f = open('in.csv', 'r')
lines = f.readlines()
for line in lines:
    data = line.split(';')
    items = [x.strip() for x in data]
    print(f'Word(rule: {getRule(items[0])}, label: "{items[0]}", correct: "{items[1]}", options: ["{items[2]}", "{items[3]}"]),')

f.close()