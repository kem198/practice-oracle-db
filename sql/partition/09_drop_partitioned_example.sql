-- テーブル削除
DROP TABLE APPUSER.PARTITIONED_EXAMPLES PURGE
;

-- 確認
SELECT
    TABLE_NAME
FROM
    USER_TABLES
;
