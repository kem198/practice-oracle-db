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
SELECT
    TABLE_NAME,
    ROW_MOVEMENT
FROM
    USER_TABLES
WHERE
    TABLE_NAME = 'PARTITIONED_EXAMPLES'
;

/************************************************
1. パーティションキー (CREATED_AT) の値を更新する

-> (失敗) ORA-14402: updating partition key column would cause a row to move to a different partition
 ************************************************/
UPDATE APPUSER.PARTITIONED_EXAMPLES
SET
    CREATED_AT = TO_TIMESTAMP('2024-05-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
;

/************************************************
2. ROW MOVEMENT を有効化

 ************************************************/
ALTER TABLE APPUSER.PARTITIONED_EXAMPLES ENABLE ROW MOVEMENT
;

/************************************************
3. パーティションキー (CREATED_AT) の値を更新し、成功する例

-> (成功) レコードが別パーティションに移動
 ************************************************/
UPDATE APPUSER.PARTITIONED_EXAMPLES
SET
    CREATED_AT = TO_TIMESTAMP('2024-05-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
;

/************************************************
4. パーティションキー以外の属性 (NAME) を更新 (常に成功する例)

-> (成功) 問題なく更新できる
 ************************************************/
UPDATE APPUSER.PARTITIONED_EXAMPLES
SET
    NAME = 'UPDATED_NAME'
WHERE
    NAME IS NOT NULL
;

/************************************************
5. 結果確認
 ************************************************/
SELECT
    *
FROM
    APPUSER.PARTITIONED_EXAMPLES
;
