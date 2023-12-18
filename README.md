# HS-LIKE
Heartbeat is an area that cannot be divined

# task

1. calculate and show result - done

2. timeline

# timeline

## func

1. add/update/delete

date: yyyy-MM-dd

type: 公演/口袋/微博/抖音/小红书/b站;

tag: 16, unit, mc2, mc3, mc4;

desc;

- 从文本自动匹配tag，不支持自选tag；

- 每个平台对应不同的tag列表；

2. list/search/order

日期范围，单选平台，文本模糊匹配，单选tag；

默认按日期降序，可切换升降序；

同一天可创建多条，分开显示；

3. type-tag crud

存在关联记录的 type-tag 不能删除, 可以编辑;

## db

1. memo_type

```sql
create table memo_type(
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
title TEXT NOT NULL
);
```

2. tag

```sql
create table tag(
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
type_id INTEGER NOT NULL,
title TEXT NOT NULL
);
```

3. memo

```sql
create table memo(
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
occur_date TEXT NOT NULL,
type_id INTEGER NOT NULL,
content TEXT NOT NULL
);
```

4. memo_tag

```sql
create table memo_tag(
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
memo_id INTEGER NOT NULL,
tag_id TEXT NOT NULL
);
```

