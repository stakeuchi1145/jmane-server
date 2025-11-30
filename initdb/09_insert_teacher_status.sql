
-- 1. 山田太郎（小6A担当）
INSERT INTO teacher_status (user_id, status, from_datetime, to_datetime)
VALUES
    (
        (SELECT id FROM users WHERE email = 'taro.yamada@example.com'),
        'RECEPTION',
        '2025-12-01 16:30:00+09',
        '2025-12-01 17:00:00+09'
    ),
    (
        (SELECT id FROM users WHERE email = 'taro.yamada@example.com'),
        'WORKING',
        '2025-12-01 17:00:00+09',
        '2025-12-01 18:30:00+09'
    ),
    (
        (SELECT id FROM users WHERE email = 'taro.yamada@example.com'),
        'REST',
        '2025-12-01 18:30:00+09',
        '2025-12-01 18:50:00+09'
    ),
    (
        (SELECT id FROM users WHERE email = 'taro.yamada@example.com'),
        'WORKING',
        '2025-12-01 19:00:00+09',
        '2025-12-01 20:30:00+09'
    ),
    (
        (SELECT id FROM users WHERE email = 'taro.yamada@example.com'),
        'RECEPTION',
        '2025-12-01 20:30:00+09',
        '2025-12-01 20:40:00+09'
    );

----------------------------------------------------------------
-- 2. 鈴木花子（小6B担当）
INSERT INTO teacher_status (user_id, status, from_datetime, to_datetime)
VALUES
    (
        (SELECT id FROM users WHERE email = 'hanako.suzuki@example.com'),
        'RECEPTION',
        '2025-12-01 16:40:00+09',
        '2025-12-01 17:00:00+09'
    ),
    (
        (SELECT id FROM users WHERE email = 'hanako.suzuki@example.com'),
        'WORKING',
        '2025-12-01 17:00:00+09',
        '2025-12-01 18:30:00+09'
    ),
    (
        (SELECT id FROM users WHERE email = 'hanako.suzuki@example.com'),
        'REST',
        '2025-12-01 18:30:00+09',
        '2025-12-01 18:55:00+09'
    ),
    (
        (SELECT id FROM users WHERE email = 'hanako.suzuki@example.com'),
        'WORKING',
        '2025-12-01 19:00:00+09',
        '2025-12-01 20:30:00+09'
    ),
    (
        (SELECT id FROM users WHERE email = 'hanako.suzuki@example.com'),
        'RECEPTION',
        '2025-12-01 20:30:00+09',
        '2025-12-01 20:45:00+09'
    );

----------------------------------------------------------------
-- 3. 伊藤健二（中1A担当）
INSERT INTO teacher_status (user_id, status, from_datetime, to_datetime)
VALUES
    (
        (SELECT id FROM users WHERE email = 'kenji.ito@example.com'),
        'RECEPTION',
        '2025-12-01 18:00:00+09',
        '2025-12-01 19:00:00+09'
    ),
    (
        (SELECT id FROM users WHERE email = 'kenji.ito@example.com'),
        'WORKING',
        '2025-12-01 19:00:00+09',
        '2025-12-01 20:30:00+09'
    ),
    (
        (SELECT id FROM users WHERE email = 'kenji.ito@example.com'),
        'RECEPTION',
        '2025-12-01 20:30:00+09',
        '2025-12-01 20:40:00+09'
    );

----------------------------------------------------------------
-- 4. 田中美香（中1B担当）
INSERT INTO teacher_status (user_id, status, from_datetime, to_datetime)
VALUES
    (
        (SELECT id FROM users WHERE email = 'mika.tanaka@example.com'),
        'RECEPTION',
        '2025-12-01 18:10:00+09',
        '2025-12-01 19:00:00+09'
    ),
    (
        (SELECT id FROM users WHERE email = 'mika.tanaka@example.com'),
        'WORKING',
        '2025-12-01 19:00:00+09',
        '2025-12-01 20:30:00+09'
    ),
    (
        (SELECT id FROM users WHERE email = 'mika.tanaka@example.com'),
        'RECEPTION',
        '2025-12-01 20:30:00+09',
        NULL -- まだ退勤処理されていない想定
    );
