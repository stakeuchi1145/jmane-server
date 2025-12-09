----------------------------------------------------------------
-- 1. 学年マスタ
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS grades (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    sort_order INTEGER NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

----------------------------------------------------------------
-- 2. 学年グループ
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS grade_groups (
    id BIGSERIAL PRIMARY KEY,
    grade_id BIGINT NOT NULL REFERENCES grades(id),
    name VARCHAR(32) NOT NULL,
    note TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS grade_groups_uq ON grade_groups (grade_id, name);

----------------------------------------------------------------
-- 3. 試験種別マスタ
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS exam_types (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS exam_types_name_uq ON exam_types(name);

----------------------------------------------------------------
-- 4. Users（講師・管理者）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    image_url VARCHAR(255),
    role VARCHAR(32) NOT NULL,        -- TEACHER / ADMIN
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS users_email_uq ON users(email);

----------------------------------------------------------------
-- 5. TeacherStatus（講師ステータス履歴）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS teacher_status (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    status VARCHAR(32) NOT NULL, -- WORKING, REST, RECEPTIONなど
    from_datetime TIMESTAMPTZ NOT NULL,
    to_datetime TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

----------------------------------------------------------------
-- 6. Students（生徒）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS students (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    grade_id BIGINT NOT NULL REFERENCES grades(id),
    grade_group_id BIGINT NOT NULL REFERENCES grade_groups(id),
    school_name VARCHAR(255),
    notes VARCHAR(255),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS students_name_idx ON students(name);

----------------------------------------------------------------
-- 7. Rooms（教室）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS rooms (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    capacity_class INTEGER NOT NULL,
    capacity_self_study INTEGER NOT NULL,
    is_corridor BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS rooms_name_uq ON rooms(name);

----------------------------------------------------------------
-- 8. ClassSessions（授業コマ）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS class_sessions (
    id BIGSERIAL PRIMARY KEY,
    room_id BIGINT NOT NULL REFERENCES rooms(id),
    teacher_id BIGINT NOT NULL REFERENCES users(id),
    grade_id BIGINT NOT NULL REFERENCES grades(id),
    grade_group_id BIGINT NOT NULL REFERENCES grade_groups(id),
    subject VARCHAR(32) NOT NULL,
    start_datetime TIMESTAMPTZ NOT NULL,
    end_datetime TIMESTAMPTZ NOT NULL,
    max_students INTEGER NOT NULL DEFAULT 10,
    is_exam BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS class_sessions_start_idx ON class_sessions(start_datetime);
CREATE INDEX IF NOT EXISTS class_sessions_room_start_idx ON class_sessions(room_id, start_datetime);

----------------------------------------------------------------
-- 9. ClassEnrollments（授業と生徒の紐付け）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS class_enrollments (
    id BIGSERIAL PRIMARY KEY,
    class_session_id BIGINT NOT NULL REFERENCES class_sessions(id),
    student_id BIGINT NOT NULL REFERENCES students(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS class_enrollments_uq
ON class_enrollments(class_session_id, student_id);

----------------------------------------------------------------
-- 10. AttendanceRecords（出席簿）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS attendance_records (
    id BIGSERIAL PRIMARY KEY,
    class_session_id BIGINT NOT NULL REFERENCES class_sessions(id),
    student_id BIGINT NOT NULL REFERENCES students(id),
    status VARCHAR(32) NOT NULL, -- NOT_ARRIVED / ARRIVED / PRESENT / LATE / ABSENT
    status_updated_at TIMESTAMPTZ NOT NULL,
    reason TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS attendance_records_uq
ON attendance_records(class_session_id, student_id);

----------------------------------------------------------------
-- 11. SelfStudySessions（自習）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS self_study_sessions (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL REFERENCES students(id),
    room_id BIGINT NOT NULL REFERENCES rooms(id),
    start_datetime TIMESTAMPTZ NOT NULL,
    end_datetime TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS self_study_open_idx
ON self_study_sessions(student_id)
WHERE end_datetime IS NULL;

----------------------------------------------------------------
-- 12. LessonReports（授業報告）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS lesson_reports (
    id BIGSERIAL PRIMARY KEY,
    class_session_id BIGINT NOT NULL REFERENCES class_sessions(id),
    teacher_id BIGINT NOT NULL REFERENCES users(id),
    content TEXT NOT NULL,
    understanding_level SMALLINT NOT NULL,
    homework TEXT,
    overall_impression TEXT,
    concerns TEXT,
    next_plan TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS lesson_reports_class_uq
ON lesson_reports(class_session_id);

----------------------------------------------------------------
-- 13. StudentGoals（生徒カルテ）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS student_goals (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL REFERENCES students(id),
    target_school_1 VARCHAR(255),
    target_school_2 VARCHAR(255),
    target_school_3 VARCHAR(255),
    target_score_level VARCHAR(255),
    weaknesses TEXT,
    note TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS student_goals_student_uq ON student_goals(student_id);

----------------------------------------------------------------
-- 14. ShiftPreferences（シフト希望）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS shift_preferences (
    id BIGSERIAL PRIMARY KEY,
    teacher_id BIGINT NOT NULL REFERENCES users(id),
    date TIMESTAMPTZ NOT NULL,
    availability VARCHAR(32) NOT NULL,
    note TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS shift_preferences_uq
ON shift_preferences(teacher_id, date);

----------------------------------------------------------------
-- 15. ShiftAssignments（確定シフト）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS shift_assignments (
    id BIGSERIAL PRIMARY KEY,
    teacher_id BIGINT NOT NULL REFERENCES users(id),
    date TIMESTAMPTZ NOT NULL,
    note TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS shift_assignments_uq
ON shift_assignments(teacher_id, date);

----------------------------------------------------------------
-- 16. Exams（試験マスタ）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS exams (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255),
    grade_id BIGINT REFERENCES grades(id),
    exam_type BIGINT REFERENCES exam_types(id),
    exam_date TIMESTAMPTZ NOT NULL,
    note TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS exams_grade_date_idx ON exams(grade_id, exam_date);

----------------------------------------------------------------
-- 17. ExamSubjects（試験科目）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS exam_subjects (
    id BIGSERIAL PRIMARY KEY,
    exam_id BIGINT REFERENCES exams(id),
    subject VARCHAR(255),
    max_score INTEGER,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS exam_subjects_uq
ON exam_subjects(exam_id, subject);

----------------------------------------------------------------
-- 18. StudentExamResults（試験結果）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS student_exam_results (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL REFERENCES students(id),
    exam_subject_id BIGINT NOT NULL REFERENCES exam_subjects(id),
    score INTEGER NOT NULL,
    deviation NUMERIC(5,2),
    rank_in_group INTEGER,
    rank_overall INTEGER,
    note TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS student_exam_results_uq
ON student_exam_results(student_id, exam_subject_id);

----------------------------------------------------------------
-- 19. StudentPresenceSessions（入退室）
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS student_presence_sessions (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL REFERENCES students(id),
    checkin_at TIMESTAMPTZ NOT NULL,
    checkout_at TIMESTAMPTZ,
    source VARCHAR(32),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_presence_open
    ON student_presence_sessions(student_id)
    WHERE checkout_at IS NULL;
