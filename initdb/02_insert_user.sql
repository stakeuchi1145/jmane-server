INSERT INTO users (name, email, password_hash, role, is_active)
VALUES
-- 管理者
('Admin User', 'admin@example.com', '$2b$10$c/XOyUA1SeOMMoi0hoFVsuIymypG7fTrFdTOTGO6U9J5mnNxqR29K', 'ADMIN', TRUE),

-- 講師
('Taro Yamada', 'taro.yamada@example.com', '$2b$10$c/XOyUA1SeOMMoi0hoFVsuIymypG7fTrFdTOTGO6U9J5mnNxqR29K', 'TEACHER', TRUE),
('Hanako Suzuki', 'hanako.suzuki@example.com', '$2b$10$c/XOyUA1SeOMMoi0hoFVsuIymypG7fTrFdTOTGO6U9J5mnNxqR29K', 'TEACHER', TRUE),
('Kenji Ito', 'kenji.ito@example.com', '$2b$10$c/XOyUA1SeOMMoi0hoFVsuIymypG7fTrFdTOTGO6U9J5mnNxqR29K', 'TEACHER', TRUE),
('Mika Tanaka', 'mika.tanaka@example.com', '$2b$10$c/XOyUA1SeOMMoi0hoFVsuIymypG7fTrFdTOTGO6U9J5mnNxqR29K', 'TEACHER', FALSE),
('Shin Takeuchi', 'shin.takeuchi@example.com', '$2b$10$c/XOyUA1SeOMMoi0hoFVsuIymypG7fTrFdTOTGO6U9J5mnNxqR29K', 'TEACHER', TRUE);
