SELECT
    cs.id AS class_session_id,
    to_char(cs.start_datetime, 'HH24:MI') AS start_time,
    to_char(cs.end_datetime, 'HH24:MI') AS end_time,
    r.name AS room_name,
    (g.name || ' ' || gg.name) AS grade_group,
    cs.subject,
    COALESCE(SUM(CASE WHEN ar.status = 'PRESENT' THEN 1 ELSE 0 END), 0) AS present_count,
    COALESCE(SUM(CASE WHEN ar.status IN ('ABSENT', 'NOT_ARRIVED') THEN 1 ELSE 0 END), 0) AS absent_count,
    COALESCE(SUM(CASE WHEN ar.status IN ('LATE', 'LATE_CANDIDATE') THEN 1 ELSE 0 END), 0) AS late_count,
    CASE WHEN lr.id IS NULL THEN '未提出' ELSE '提出済み' END AS report_status
FROM class_sessions cs
         JOIN rooms r ON cs.room_id = r.id
         JOIN grades g ON cs.grade_id = g.id
         JOIN grade_groups gg ON cs.grade_group_id = gG.id
         LEFT JOIN attendance_records ar ON ar.class_session_id = cs.id
         LEFT JOIN lesson_reports lr ON lr.class_session_id = cs.id
WHERE cs.teacher_id = ?
  AND cs.start_datetime::date = CAST(? AS date)
GROUP BY cs.id, r.name, g.name, gg.name, cs.subject, lr.id;
