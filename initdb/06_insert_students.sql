-- 小学6年 Aクラス
INSERT INTO students (name, grade_id, grade_group_id, school_name, notes, is_active)
VALUES
    ('佐藤太一',
     (SELECT id FROM grades WHERE name = '小学6年'),
     (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
      WHERE g.name = '小学6年' AND gg.name = 'Aクラス'),
     '市立第一小学校', NULL, TRUE),
    ('鈴木花子',
     (SELECT id FROM grades WHERE name = '小学6年'),
     (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
      WHERE g.name = '小学6年' AND gg.name = 'Aクラス'),
     '市立第一小学校', NULL, TRUE),
    ('田中陽斗',
     (SELECT id FROM grades WHERE name = '小学6年'),
     (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
      WHERE g.name = '小学6年' AND gg.name = 'Aクラス'),
     '市立第一小学校', NULL, TRUE);

-- 小学6年 Bクラス
INSERT INTO students (name, grade_id, grade_group_id, school_name, notes, is_active)
VALUES
    ('高橋美咲',
     (SELECT id FROM grades WHERE name = '小学6年'),
     (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
      WHERE g.name = '小学6年' AND gg.name = 'Bクラス'),
     '市立第二小学校', NULL, TRUE),
    ('伊藤蓮',
     (SELECT id FROM grades WHERE name = '小学6年'),
     (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
      WHERE g.name = '小学6年' AND gg.name = 'Bクラス'),
     '市立第二小学校', NULL, TRUE),
    ('中村優奈',
     (SELECT id FROM grades WHERE name = '小学6年'),
     (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
      WHERE g.name = '小学6年' AND gg.name = 'Bクラス'),
     '市立第二小学校', NULL, TRUE);

-- 中学1年 Aクラス
INSERT INTO students (name, grade_id, grade_group_id, school_name, notes, is_active)
VALUES
    ('山本大輝',
     (SELECT id FROM grades WHERE name = '中学1年'),
     (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
      WHERE g.name = '中学1年' AND gg.name = 'Aクラス'),
     '市立第一中学校', NULL, TRUE),
    ('小林さくら',
     (SELECT id FROM grades WHERE name = '中学1年'),
     (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
      WHERE g.name = '中学1年' AND gg.name = 'Aクラス'),
     '市立第一中学校', NULL, TRUE),
    ('加藤陸',
     (SELECT id FROM grades WHERE name = '中学1年'),
     (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
      WHERE g.name = '中学1年' AND gg.name = 'Aクラス'),
     '市立第一中学校', NULL, TRUE);

-- 中学1年 Bクラス
INSERT INTO students (name, grade_id, grade_group_id, school_name, notes, is_active)
VALUES
    ('吉田彩',
     (SELECT id FROM grades WHERE name = '中学1年'),
     (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
      WHERE g.name = '中学1年' AND gg.name = 'Bクラス'),
     '市立第二中学校', NULL, TRUE),
    ('山田悠真',
     (SELECT id FROM grades WHERE name = '中学1年'),
     (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
      WHERE g.name = '中学1年' AND gg.name = 'Bクラス'),
     '市立第二中学校', NULL, TRUE),
    ('斎藤結衣',
     (SELECT id FROM grades WHERE name = '中学1年'),
     (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
      WHERE g.name = '中学1年' AND gg.name = 'Bクラス'),
     '市立第二中学校', NULL, TRUE);