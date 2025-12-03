-- 小6Aクラス
INSERT INTO class_enrollments (class_session_id, student_id)
VALUES
    (
        (SELECT cs.id FROM class_sessions cs
                               JOIN grade_groups gg ON cs.grade_group_id = gg.id
                               JOIN grades g ON cs.grade_id = g.id
         WHERE g.name = '小学6年' AND gg.name = 'Aクラス'
           AND cs.subject = '算数'
           AND cs.start_datetime = '2025-12-01 17:00:00+09'),
        (SELECT id FROM students WHERE name = '佐藤太一')
    ),
    (
        (SELECT cs.id FROM class_sessions cs
                               JOIN grade_groups gg ON cs.grade_group_id = gg.id
                               JOIN grades g ON cs.grade_id = g.id
         WHERE g.name = '小学6年' AND gg.name = 'Aクラス'
           AND cs.subject = '算数'
           AND cs.start_datetime = '2025-12-01 17:00:00+09'),
        (SELECT id FROM students WHERE name = '鈴木花子')
    ),
    (
        (SELECT cs.id FROM class_sessions cs
                               JOIN grade_groups gg ON cs.grade_group_id = gg.id
                               JOIN grades g ON cs.grade_id = g.id
         WHERE g.name = '小学6年' AND gg.name = 'Aクラス'
           AND cs.subject = '算数'
           AND cs.start_datetime = '2025-12-01 17:00:00+09'),
        (SELECT id FROM students WHERE name = '田中陽斗')
    );

-- 小6Bクラス
INSERT INTO class_enrollments (class_session_id, student_id)
VALUES
    (
        (SELECT cs.id FROM class_sessions cs
                               JOIN grade_groups gg ON cs.grade_group_id = gg.id
                               JOIN grades g ON cs.grade_id = g.id
         WHERE g.name = '小学6年' AND gg.name = 'Bクラス'
           AND cs.subject = '国語'
           AND cs.start_datetime = '2025-12-01 17:00:00+09'),
        (SELECT id FROM students WHERE name = '高橋美咲')
    ),
    (
        (SELECT cs.id FROM class_sessions cs
                               JOIN grade_groups gg ON cs.grade_group_id = gg.id
                               JOIN grades g ON cs.grade_id = g.id
         WHERE g.name = '小学6年' AND gg.name = 'Bクラス'
           AND cs.subject = '国語'
           AND cs.start_datetime = '2025-12-01 17:00:00+09'),
        (SELECT id FROM students WHERE name = '伊藤蓮')
    ),
    (
        (SELECT cs.id FROM class_sessions cs
                               JOIN grade_groups gg ON cs.grade_group_id = gg.id
                               JOIN grades g ON cs.grade_id = g.id
         WHERE g.name = '小学6年' AND gg.name = 'Bクラス'
           AND cs.subject = '国語'
           AND cs.start_datetime = '2025-12-01 17:00:00+09'),
        (SELECT id FROM students WHERE name = '中村優奈')
    );

-- 中1Aクラス
INSERT INTO class_enrollments (class_session_id, student_id)
VALUES
    (
        (SELECT cs.id FROM class_sessions cs
                               JOIN grade_groups gg ON cs.grade_group_id = gg.id
                               JOIN grades g ON cs.grade_id = g.id
         WHERE g.name = '中学1年' AND gg.name = 'Aクラス'
           AND cs.subject = '数学'
           AND cs.start_datetime = '2025-12-01 19:00:00+09'),
        (SELECT id FROM students WHERE name = '山本大輝')
    ),
    (
        (SELECT cs.id FROM class_sessions cs
                               JOIN grade_groups gg ON cs.grade_group_id = gg.id
                               JOIN grades g ON cs.grade_id = g.id
         WHERE g.name = '中学1年' AND gg.name = 'Aクラス'
           AND cs.subject = '数学'
           AND cs.start_datetime = '2025-12-01 19:00:00+09'),
        (SELECT id FROM students WHERE name = '小林さくら')
    ),
    (
        (SELECT cs.id FROM class_sessions cs
                               JOIN grade_groups gg ON cs.grade_group_id = gg.id
                               JOIN grades g ON cs.grade_id = g.id
         WHERE g.name = '中学1年' AND gg.name = 'Aクラス'
           AND cs.subject = '数学'
           AND cs.start_datetime = '2025-12-01 19:00:00+09'),
        (SELECT id FROM students WHERE name = '加藤陸')
    );

-- 中1Bクラス
INSERT INTO class_enrollments (class_session_id, student_id)
VALUES
    (
        (SELECT cs.id FROM class_sessions cs
                               JOIN grade_groups gg ON cs.grade_group_id = gg.id
                               JOIN grades g ON cs.grade_id = g.id
         WHERE g.name = '中学1年' AND gg.name = 'Bクラス'
           AND cs.subject = '英語'
           AND cs.start_datetime = '2025-12-01 19:00:00+09'),
        (SELECT id FROM students WHERE name = '吉田彩')
    ),
    (
        (SELECT cs.id FROM class_sessions cs
                               JOIN grade_groups gg ON cs.grade_group_id = gg.id
                               JOIN grades g ON cs.grade_id = g.id
         WHERE g.name = '中学1年' AND gg.name = 'Bクラス'
           AND cs.subject = '英語'
           AND cs.start_datetime = '2025-12-01 19:00:00+09'),
        (SELECT id FROM students WHERE name = '山田悠真')
    ),
    (
        (SELECT cs.id FROM class_sessions cs
                               JOIN grade_groups gg ON cs.grade_group_id = gg.id
                               JOIN grades g ON cs.grade_id = g.id
         WHERE g.name = '中学1年' AND gg.name = 'Bクラス'
           AND cs.subject = '英語'
           AND cs.start_datetime = '2025-12-01 19:00:00+09'),
        (SELECT id FROM students WHERE name = '斎藤結衣')
    );
