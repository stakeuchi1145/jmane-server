INSERT INTO users (name, email, password_hash, image_url, role, is_active)
VALUES
-- 管理者
('Admin User', 'admin@example.com', '$2b$10$c/XOyUA1SeOMMoi0hoFVsuIymypG7fTrFdTOTGO6U9J5mnNxqR29K', '', 'ADMIN', TRUE),

-- 講師
('Taro Yamada', 'taro.yamada@example.com', '$2b$10$c/XOyUA1SeOMMoi0hoFVsuIymypG7fTrFdTOTGO6U9J5mnNxqR29K', 'user/TY001.png', 'TEACHER', TRUE),
('Hanako Suzuki', 'hanako.suzuki@example.com', '$2b$10$c/XOyUA1SeOMMoi0hoFVsuIymypG7fTrFdTOTGO6U9J5mnNxqR29K', 'user/HS001.png', 'TEACHER', TRUE),
('Kenji Ito', 'kenji.ito@example.com', '$2b$10$c/XOyUA1SeOMMoi0hoFVsuIymypG7fTrFdTOTGO6U9J5mnNxqR29K', 'user/KI001.png', 'TEACHER', TRUE),
('Mika Tanaka', 'mika.tanaka@example.com', '$2b$10$c/XOyUA1SeOMMoi0hoFVsuIymypG7fTrFdTOTGO6U9J5mnNxqR29K', 'user/MT001.png', 'TEACHER', FALSE);
