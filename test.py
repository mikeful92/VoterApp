import sqlite3

def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d


con = sqlite3.Connection('../Data/DB.sqlite')
cur = con.cursor()

cur.execute('SELECT * FROM VOTERS WHERE ZipCode = "33486";')

rows = cur.fetchall()

data = []
for row in rows:
    data.append(','.join(row))

print('\n'.join(data))
