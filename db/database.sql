-- to apply uuid in project
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- patient table creation
CREATE TABLE patients (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), 
  ism VARCHAR(255) NOT NULL, 
  yosh INTEGER, 
  tibbiy_tarix TEXT, 
  contact_info JSON, 
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--create custom data type enum
CREATE TYPE status_type AS ENUM (
  'rejalashtirilgan', 'tugallangan', 
  'bekor qilingan'
) 

--appointments table creation
CREATE TABLE appointments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), 
  bemor_identifikatori UUID REFERENCES patients(id), 
  doctor_name VARCHAR(255) NOT NULL, 
  tayinlash_sanasi DATE, 
  status status_type, 
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
  updated_at TIMESTAMP DEFAULT null
)

--insert example data
INSERT INTO patients (id, ism, yosh, tibbiy_tarix, contact_info) VALUES ('95b03502-4ce3-4dd3-90e8-11836029fad7','John Doe', 45, 'Qandli diabet, Gipertenziya','{
 "phone": "123-456-7890",
 "email": "john.doe@example.com",
 "address": "Main St, 123, Anytown, AQSH"
 }');

 INSERT INTO appointments (id, bemor_identifikatori, doctor_name, tayinlash_sanasi, status) VALUES ('14b03502-4fd5-4dd3-90e8-11836029fbc7', '95b03502-4ce3-4dd3-90e8-11836029fad7', 'John Doe', CURRENT_DATE, 'rejalashtirilgan');


 -- Bemor yozuvini tizimdan olib tashlang.
 DELETE * from patients WHERE id = '95b03502-4ce3-4dd3-90e8-11836029fad7'


-- Belgilangan sana oralig'ida barcha bemorlarni qabul qilish.
SELECT * FROM patients WHERE created_at::DATE BETWEEN '2024-12-08' AND '2024-12-09'

-- Muayyan tibbiy holati bo'lgan barcha bemorlarni oling.
SELECT * FROM patients WHERE tibbiy_tarix = 'Qandli diabet, Gipertenziya'

-- Muayyan shifokor uchun barcha uchrashuvlarni oling.
SELECT * FROM appointments WHERE doctor_name = 'John Doe'

-- Muayyan vaqt oralig'ida qabul qilinmagan barcha bemorlarni oling.
SELECT * FROM appointments WHERE tayinlash_sanasi::DATE NOT BETWEEN '2024-12-08' AND '2024-12-09'

-- Ikki aniq sana o'rtasida rejalashtirilgan uchrashuvlar bo'lgan bemorlarni aniqlang.
SELECT p.* FROM patients p  INNER JOIN appointments a ON p.id = a.bemor_identifikatori AND a.status = 'rejalashtirilgan' AND a.created_at::DATE BETWEEN '2024-12-08' AND '2024-12-09'

-- Kasallik tarixida qayd etilgan muayyan kasallikka chalingan bemorlarni toping.
SELECT * FROM patients WHERE tibbiy_tarix LIKE '%Gipertenziya%'

-- Muayyan shifokor bilan rejalashtirilgan barcha uchrashuvlarni sanab o'ting.
SELECT * FROM appointments WHERE doctor_name = 'John Doe'

-- So'nggi bir necha oy ichida (masalan, so'nggi 6 oyda) hech qanday uchrashuv o'tkazmagan bemorlarni toping.
SELECT p.* FROM patients p  INNER JOIN appointments a ON p.id = a.bemor_identifikatori WHERE a.created_at >= CURRENT_DATE - INTERVAL '60 days'

