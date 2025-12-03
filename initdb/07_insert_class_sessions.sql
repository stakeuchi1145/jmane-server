INSERT INTO class_sessions
(room_id, teacher_id, grade_id, grade_group_id,
 subject, start_datetime, end_datetime, max_students, is_exam)
VALUES
    -- 小6A 算数
    (
        (SELECT id FROM rooms WHERE name = '第1教室'),
        (SELECT id FROM users WHERE email = 'taro.yamada@example.com'),
        (SELECT id FROM grades WHERE name = '小学6年'),
        (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
         WHERE g.name = '小学6年' AND gg.name = 'Aクラス'),
        '算数',
        '2025-12-01 17:00:00+09',
        '2025-12-01 18:30:00+09',
        10,
        FALSE
    ),
    -- 小6B 国語
    (
        (SELECT id FROM rooms WHERE name = '第2教室'),
        (SELECT id FROM users WHERE email = 'hanako.suzuki@example.com'),
        (SELECT id FROM grades WHERE name = '小学6年'),
        (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
         WHERE g.name = '小学6年' AND gg.name = 'Bクラス'),
        '国語',
        '2025-12-01 17:00:00+09',
        '2025-12-01 18:30:00+09',
        10,
        FALSE
    ),
    -- 中1A 数学
    (
        (SELECT id FROM rooms WHERE name = '第1教室'),
        (SELECT id FROM users WHERE email = 'kenji.ito@example.com'),
        (SELECT id FROM grades WHERE name = '中学1年'),
        (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
         WHERE g.name = '中学1年' AND gg.name = 'Aクラス'),
        '数学',
        '2025-12-01 19:00:00+09',
        '2025-12-01 20:30:00+09',
        10,
        FALSE
    ),
    -- 中1B 英語
    (
        (SELECT id FROM rooms WHERE name = '第2教室'),
        (SELECT id FROM users WHERE email = 'mika.tanaka@example.com'),
        (SELECT id FROM grades WHERE name = '中学1年'),
        (SELECT gg.id FROM grade_groups gg JOIN grades g ON gg.grade_id = g.id
         WHERE g.name = '中学1年' AND gg.name = 'Bクラス'),
        '英語',
        '2025-12-01 19:00:00+09',
        '2025-12-01 20:30:00+09',
        10,
        FALSE
    );