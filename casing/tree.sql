-- -- Write your PostgreSQL query statement below
-- SELECT
--     id,
--     CASE
--         WHEN p_id IS NULL THEN 'Root'  -- Node has no parent, it's the root
--         WHEN id NOT IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Leaf'  -- Node is not a parent of any other node, it's a leaf
--         ELSE 'Inner'  -- Node has a parent and at least one child, it's an inner node
--     END AS "type"
-- FROM Tree;
WITH ParentNodes AS (
    SELECT DISTINCT p_id 
    FROM Tree 
    WHERE p_id IS NOT NULL
)
SELECT
    id,
    CASE
        WHEN p_id IS NULL THEN 'Root'
        WHEN id NOT IN (SELECT p_id FROM ParentNodes) THEN 'Leaf'
        ELSE 'Inner'
    END AS "type"
FROM Tree;
