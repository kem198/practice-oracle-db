-- @/sql/partition/02_check_partition_queries.sql
/************************************************
0. 現在の設定値の確認

- PARTITION KEY: CREATED_AT へ設定済み
- ROW MOVEMENT: 無効

-> パーティション情報と ROW MOVEMENT の状態を確認
 ************************************************/
-- パーティション情報の確認
SELECT
    TABLE_NAME,
    PARTITIONING_TYPE,
    PARTITION_COUNT
FROM
    USER_PART_TABLES
WHERE
    TABLE_NAME = 'PARTITIONED_EXAMPLES'
;

-- ROW MOVEMENT の状態確認
-- -> ROW_MOVEMENT: DISABLED
SELECT
    TABLE_NAME,
    ROW_MOVEMENT
FROM
    USER_TABLES
WHERE
    TABLE_NAME = 'PARTITIONED_EXAMPLES'
;

/************************************************
1. パーティションキー以外の属性 (NAME) を更新

-> (成功) 問題なく更新できる
 ************************************************/
UPDATE APPUSER.PARTITIONED_EXAMPLES
SET
    NAME = 'Alice ★UPDATED'
WHERE
    ID = 1
;

SELECT
    *
FROM
    APPUSER.PARTITIONED_EXAMPLES
ORDER BY
    ID
;

/************************************************
2. パーティションキー (CREATED_AT) の値を更新する

-> (失敗)
ORA-14402: updating partition key column would cause a row to move to a different partition
ORA-14402: パーティション・キー列を更新するとパーティションが変更されます。
 ************************************************/
UPDATE APPUSER.PARTITIONED_EXAMPLES
SET
    CREATED_AT = SYSTIMESTAMP
WHERE
    ID = 1
;

/************************************************
3. ROW MOVEMENT を有効化

 ************************************************/
-- 有効化
ALTER TABLE APPUSER.PARTITIONED_EXAMPLES ENABLE ROW MOVEMENT
;

-- ROW MOVEMENT の状態確認
-- -> ROW_MOVEMENT: ENABLED
SELECT
    TABLE_NAME,
    ROW_MOVEMENT
FROM
    USER_TABLES
WHERE
    TABLE_NAME = 'PARTITIONED_EXAMPLES'
;

/************************************************
4. パーティションキー (CREATED_AT) の値を更新し、成功する例

-> (成功) レコードが別パーティションに移動
 ************************************************/
UPDATE APPUSER.PARTITIONED_EXAMPLES
SET
    CREATED_AT = SYSTIMESTAMP
WHERE
    ID = 1
;

-- または下記
UPDATE APPUSER.PARTITIONED_EXAMPLES
SET
    CREATED_AT = TO_TIMESTAMP(
        '2099-01-01 09:00:00.000',
        'YYYY-MM-DD HH24:MI:SS.FF3'
    )
WHERE
    ID = 1
;

/************************************************
5. 結果確認
 ************************************************/
SELECT
    *
FROM
    APPUSER.PARTITIONED_EXAMPLES
ORDER BY
    ID
;

SELECT
    *
FROM
    APPUSER.PARTITIONED_EXAMPLES PARTITION (p2023)
ORDER BY
    ID
;

SELECT
    *
FROM
    APPUSER.PARTITIONED_EXAMPLES PARTITION (p2024)
ORDER BY
    ID
;

SELECT
    *
FROM
    APPUSER.PARTITIONED_EXAMPLES PARTITION (p2025)
ORDER BY
    ID
;

SELECT
    *
FROM
    APPUSER.PARTITIONED_EXAMPLES PARTITION (pmax)
ORDER BY
    ID
;
