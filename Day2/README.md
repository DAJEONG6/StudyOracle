## 2일차 학습
### WHERE절

```sql
SELECT ename, job, sal, sal * 12  AS annsal
    FROM empp
    WHERE NOT sal >= 10000;