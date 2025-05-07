-- 시퀀스 드롭
DROP SEQUENCE seq_orders;
DROP SEQUENCE seq_order_status_history;
DROP SEQUENCE seq_transaction_documents;
DROP SEQUENCE seq_notice_board;
DROP SEQUENCE seq_inoutvoice;
DROP SEQUENCE seq_stock_history;
DROP SEQUENCE seq_approval_documents;

-- 기존 테이블 드롭 (의존성 역순으로 삭제)
DROP TABLE TB_NOTICE_BOARD CASCADE CONSTRAINTS;
DROP TABLE TB_ROLE_PERMISSION CASCADE CONSTRAINTS;
DROP TABLE TB_PERMISSION_CODE CASCADE CONSTRAINTS;
DROP TABLE TB_USER_ROLE CASCADE CONSTRAINTS;
DROP TABLE TB_ROLE_GROUP CASCADE CONSTRAINTS;
DROP TABLE TB_TRANSACTION_DOCUMENTS CASCADE CONSTRAINTS;
DROP TABLE TB_APPROVAL_DOCUMENTS CASCADE CONSTRAINTS;
DROP TABLE TB_INOUTVOICE CASCADE CONSTRAINTS;
DROP TABLE TB_ORDER_STATUS_HISTORY CASCADE CONSTRAINTS;
DROP TABLE TB_STOCK_HISTORY CASCADE CONSTRAINTS;
DROP TABLE TB_ORDERS CASCADE CONSTRAINTS;
DROP TABLE TB_WAREHOUSE_STOCK CASCADE CONSTRAINTS;
DROP TABLE TB_PRODUCT CASCADE CONSTRAINTS;
DROP TABLE TB_WAREHOUSE CASCADE CONSTRAINTS;
DROP TABLE TB_PARTNER CASCADE CONSTRAINTS;
DROP TABLE TB_USER CASCADE CONSTRAINTS;


-- 시퀀스 생성
CREATE SEQUENCE seq_orders START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 999 NOCYCLE NOCACHE;
CREATE SEQUENCE seq_order_status_history START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 999 NOCYCLE NOCACHE;
CREATE SEQUENCE seq_transaction_documents START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_notice_board START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_inoutvoice START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 999 NOCYCLE NOCACHE;
CREATE SEQUENCE seq_stock_history START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 999 NOCYCLE NOCACHE;
CREATE SEQUENCE seq_approval_documents START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 999 NOCYCLE NOCACHE;

-- 1. TB_USER
CREATE TABLE TB_USER (
    empid VARCHAR2(20) PRIMARY KEY,
    empname VARCHAR2(50) NOT NULL,
    department VARCHAR2(50),
    job VARCHAR2(50)CHECK (job IN ('사원','대리', '과장', '부장', '이사')),
    email VARCHAR2(100) NOT NULL UNIQUE,
    phone VARCHAR2(20) NOT NULL UNIQUE,
    empno VARCHAR2(20) NOT NULL UNIQUE,
    hire_date DATE,
    address VARCHAR2(255),
    emppwd VARCHAR2(128) NOT NULL,
    admin_yn VARCHAR2(1) NOT NULL CHECK (admin_yn IN ('Y','N')),
    last_login_date DATE,
    is_active VARCHAR2(1) DEFAULT 'Y' CHECK (is_active IN ('Y','N'))
);

COMMENT ON COLUMN TB_USER.empid IS '사원번호'; 
COMMENT ON COLUMN TB_USER.empname IS '사용자 이름'; 
COMMENT ON COLUMN TB_USER.department IS '부서'; 
COMMENT ON COLUMN TB_USER.job IS '직무'; 
COMMENT ON COLUMN TB_USER.email IS '이메일'; 
COMMENT ON COLUMN TB_USER.phone IS '전화번호'; 
COMMENT ON COLUMN TB_USER.empno IS '주민등록번호'; 
COMMENT ON COLUMN TB_USER.hire_date IS '입사일'; 
COMMENT ON COLUMN TB_USER.address IS '주소'; 
COMMENT ON COLUMN TB_USER.emppwd IS '비밀번호'; 
COMMENT ON COLUMN TB_USER.admin_yn IS '관리자 여부 (Y/N)';
COMMENT ON COLUMN TB_USER.last_login_date IS '마지막 로그인 날짜'; 
COMMENT ON COLUMN TB_USER.is_active IS '계정 활성화 여부 (Y/N)';


-- 2. TB_PARTNER
CREATE TABLE TB_PARTNER (
    partner_id VARCHAR2(20) PRIMARY KEY,
    partner_type VARCHAR2(20) NOT NULL CHECK (partner_type IN ('공급처', '판매처')),
    partner_name VARCHAR2(100) NOT NULL,
    empid VARCHAR2(20) NOT NULL,
    manager_name VARCHAR2(50),
    contact_info VARCHAR2(50),
    email VARCHAR2(100),
    partner_address VARCHAR2(255),
    business_reg_no VARCHAR2(50),
    representative_name VARCHAR2(50),
    corporate_type VARCHAR2(50),
    transaction_status VARCHAR2(100) DEFAULT 'Active',
    CONSTRAINT fk_partner_empid FOREIGN KEY (empid) REFERENCES TB_USER(empid) ON DELETE CASCADE
);

COMMENT ON COLUMN TB_PARTNER.partner_id IS '거래처 ID'; 
COMMENT ON COLUMN TB_PARTNER.partner_type IS '거래처 유형'; 
COMMENT ON COLUMN TB_PARTNER.partner_name IS '거래처 이름';
COMMENT ON COLUMN TB_PARTNER.empid IS '담당자 ID'; 
COMMENT ON COLUMN TB_PARTNER.manager_name IS '담당자 이름'; 
COMMENT ON COLUMN TB_PARTNER.contact_info IS '연락처'; 
COMMENT ON COLUMN TB_PARTNER.email IS '이메일'; 
COMMENT ON COLUMN TB_PARTNER.partner_address IS '거래처 주소'; 
COMMENT ON COLUMN TB_PARTNER.business_reg_no IS '사업자 등록번호'; 
COMMENT ON COLUMN TB_PARTNER.representative_name IS '대표자 이름'; 
COMMENT ON COLUMN TB_PARTNER.corporate_type IS '기업 유형'; 
COMMENT ON COLUMN TB_PARTNER.transaction_status IS '거래 상태';


-- 3. TB_WAREHOUSE
CREATE TABLE TB_WAREHOUSE (
    warehouse_id VARCHAR2(20) PRIMARY KEY,
    warehouse_type VARCHAR2(10) NOT NULL,
    warehouse_name VARCHAR2(100) NOT NULL,
    warehouse_address VARCHAR2(255),
    warehouse_area NUMBER,
    empid VARCHAR2(20) NOT NULL,
    manager_name VARCHAR2(50),
    contact_info VARCHAR2(50),
    email VARCHAR2(100),
    CONSTRAINT fk_warehouse_empid FOREIGN KEY (empid) REFERENCES TB_USER(empid) ON DELETE CASCADE
);

COMMENT ON COLUMN TB_WAREHOUSE.warehouse_id IS '창고 ID'; 
COMMENT ON COLUMN TB_WAREHOUSE.warehouse_type IS '창고 유형'; 
COMMENT ON COLUMN TB_WAREHOUSE.warehouse_name IS '창고 이름'; 
COMMENT ON COLUMN TB_WAREHOUSE.warehouse_address IS '창고 주소'; 
COMMENT ON COLUMN TB_WAREHOUSE.warehouse_area IS '창고 면적'; 
COMMENT ON COLUMN TB_WAREHOUSE.empid IS '담당자 ID'; 
COMMENT ON COLUMN TB_WAREHOUSE.manager_name IS '담당자 이름'; 
COMMENT ON COLUMN TB_WAREHOUSE.contact_info IS '연락처'; 
COMMENT ON COLUMN TB_WAREHOUSE.email IS '이메일'; 


-- 4. TB_PRODUCT
CREATE TABLE TB_PRODUCT (
    product_id VARCHAR2(50) PRIMARY KEY,
    product_name VARCHAR2(255) NOT NULL,
    option_value VARCHAR2(100),
    product_type VARCHAR2(20) NOT NULL CHECK (product_type IN ('부품', '완제품')),
    cost_price NUMBER(10,2) NOT NULL,
    selling_price NUMBER(10,2) NOT NULL,
    manufacturer VARCHAR2(100),
    country_of_origin VARCHAR2(100),
    partner_id VARCHAR2(20),
    category VARCHAR2(100),
    safe_stock NUMBER DEFAULT 0,
    product_image BLOB,
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE,
    CONSTRAINT fk_product_partner_id FOREIGN KEY (partner_id) REFERENCES TB_PARTNER(partner_id) ON DELETE CASCADE
);

COMMENT ON COLUMN TB_PRODUCT.product_id IS '상품 ID'; 
COMMENT ON COLUMN TB_PRODUCT.product_name IS '상품 이름'; 
COMMENT ON COLUMN TB_PRODUCT.option_value IS '상품 옵션'; 
COMMENT ON COLUMN TB_PRODUCT.product_type IS '상품 유형'; 
COMMENT ON COLUMN TB_PRODUCT.cost_price IS '원가'; 
COMMENT ON COLUMN TB_PRODUCT.selling_price IS '판매가'; 
COMMENT ON COLUMN TB_PRODUCT.manufacturer IS '제조사'; 
COMMENT ON COLUMN TB_PRODUCT.country_of_origin IS '원산지'; 
COMMENT ON COLUMN TB_PRODUCT.partner_id IS '거래처 ID'; 
COMMENT ON COLUMN TB_PRODUCT.category IS '카테고리'; 
COMMENT ON COLUMN TB_PRODUCT.safe_stock IS '안전 재고 수량'; 
COMMENT ON COLUMN TB_PRODUCT.product_image IS '제품 이미지'; 
COMMENT ON COLUMN TB_PRODUCT.created_at IS '등록일'; 
COMMENT ON COLUMN TB_PRODUCT.updated_at IS '수정일';



-- 5. TB_WAREHOUSE_STOCK
CREATE TABLE TB_WAREHOUSE_STOCK (
    warehouse_id VARCHAR2(20),
    product_id VARCHAR2(50),
    stock NUMBER DEFAULT 0,
    CONSTRAINT pk_warehouse_stock PRIMARY KEY (warehouse_id, product_id),
    CONSTRAINT fk_wstock_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES TB_WAREHOUSE(warehouse_id) ON DELETE CASCADE,
    CONSTRAINT fk_wstock_product_id FOREIGN KEY (product_id) REFERENCES TB_PRODUCT(product_id) ON DELETE CASCADE
);

COMMENT ON COLUMN TB_WAREHOUSE_STOCK.warehouse_id IS '창고 ID'; 
COMMENT ON COLUMN TB_WAREHOUSE_STOCK.product_id IS '제품 ID'; 
COMMENT ON COLUMN TB_WAREHOUSE_STOCK.stock IS '재고 수량'; 


-- 6. TB_ORDERS
CREATE TABLE TB_ORDERS (
    order_id VARCHAR2(20) PRIMARY KEY,
    partner_id VARCHAR2(20),
    product_id VARCHAR2(50) NOT NULL,
    quantity NUMBER NOT NULL,
    order_type VARCHAR2(20) NOT NULL CHECK (order_type IN ('발주', '수주')),
    order_status VARCHAR2(20) NOT NULL CHECK (order_status IN ('접수', '처리중', '완료', '취소')),
    created_at DATE,
    CONSTRAINT fk_orders_partner_id FOREIGN KEY (partner_id) REFERENCES TB_PARTNER(partner_id)ON DELETE CASCADE,
    CONSTRAINT fk_orders_product_id FOREIGN KEY (product_id) REFERENCES TB_PRODUCT(product_id)ON DELETE CASCADE
);

COMMENT ON COLUMN TB_ORDERS.order_id IS '주문 ID'; 
COMMENT ON COLUMN TB_ORDERS.partner_id IS '거래처 ID'; 
COMMENT ON COLUMN TB_ORDERS.product_id IS '상품 ID'; 
COMMENT ON COLUMN TB_ORDERS.quantity IS '주문 수량'; 
COMMENT ON COLUMN TB_ORDERS.order_type IS '주문 유형'; 
COMMENT ON COLUMN TB_ORDERS.order_status IS '재고 상태'; 
COMMENT ON COLUMN TB_ORDERS.created_at IS '주문 등록일';


-- 7. TB_STOCK_HISTORY
CREATE TABLE TB_STOCK_HISTORY (
    stock_history_id VARCHAR2(20) PRIMARY KEY,
    warehouse_id VARCHAR2(20) NOT NULL,
    product_id VARCHAR2(50) NOT NULL,
    stock_quantity NUMBER NOT NULL,
    change_quantity NUMBER NOT NULL,
    change_type VARCHAR2(10) NOT NULL CHECK (change_type IN ('입고', '출고')),
    change_date DATE DEFAULT SYSDATE,
    Inoutvoice_id VARCHAR2(20),
    created_by VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_stockhist_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES TB_WAREHOUSE(warehouse_id)ON DELETE CASCADE,
    CONSTRAINT fk_stockhist_product_id FOREIGN KEY (product_id) REFERENCES TB_PRODUCT(product_id)ON DELETE CASCADE,
    CONSTRAINT fk_stockhist_created_by FOREIGN KEY (created_by) REFERENCES TB_USER(empid)ON DELETE CASCADE
);

COMMENT ON COLUMN TB_STOCK_HISTORY.stock_history_id IS '재고 이력 ID'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.warehouse_id IS '창고 ID'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.product_id IS '제품 ID'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.stock_quantity IS '현재 재고 수량'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.change_quantity IS '변경 수량';
COMMENT ON COLUMN TB_STOCK_HISTORY.change_type IS '변경 유형'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.Inoutvoice_id IS '입출고 전표 id'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.change_date IS '변경 날짜'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.created_by IS '변경자 ID';


-- 8. TB_ORDER_STATUS_HISTORY
CREATE TABLE TB_ORDER_STATUS_HISTORY (
    status_history_id NUMBER PRIMARY KEY,
    order_id VARCHAR2(20) NOT NULL,
    prev_order_status VARCHAR2(20),
    order_status VARCHAR2(20) NOT NULL CHECK (order_status IN ('접수', '처리중', '완료', '취소')),
    status_change_date DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_orderstatus_order_id FOREIGN KEY (order_id) REFERENCES TB_ORDERS(order_id)ON DELETE CASCADE
);

COMMENT ON COLUMN TB_ORDER_STATUS_HISTORY.status_history_id IS '상태 이력 ID'; 
COMMENT ON COLUMN TB_ORDER_STATUS_HISTORY.order_id IS '주문 ID'; 
COMMENT ON COLUMN TB_ORDER_STATUS_HISTORY.prev_order_status IS '이전 주문 상태'; 
COMMENT ON COLUMN TB_ORDER_STATUS_HISTORY.order_status IS '현재 주문 상태';
COMMENT ON COLUMN TB_ORDER_STATUS_HISTORY.status_change_date IS '상태 변경 일자';


-- 9. TB_INOUTVOICE
CREATE TABLE TB_INOUTVOICE (
    Inoutvoice_id VARCHAR2(20) PRIMARY KEY,
    Inoutvoice_name VARCHAR2(100) NOT NULL,
    Inoutvoice_type VARCHAR2(10) NOT NULL CHECK (inoutvoice_type IN ('입고', '출고')),
    order_id VARCHAR2(20) NOT NULL,
    worker_id VARCHAR2(20) NOT NULL,
    warehouse_id VARCHAR2(20) NOT NULL,
    created_at DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_inoutvoice_order_id FOREIGN KEY (order_id) REFERENCES TB_ORDERS(order_id)ON DELETE CASCADE,
    CONSTRAINT fk_inoutvoice_worker_id FOREIGN KEY (worker_id) REFERENCES TB_USER(empid)ON DELETE CASCADE,
    CONSTRAINT fk_inoutvoice_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES TB_WAREHOUSE(warehouse_id)ON DELETE CASCADE
);

-- 재고 이력 테이블 외래키 추가
ALTER TABLE TB_STOCK_HISTORY
ADD CONSTRAINT fk_stockhist_Inoutvoice_id FOREIGN KEY (Inoutvoice_id) REFERENCES TB_INOUTVOICE(Inoutvoice_id)ON DELETE CASCADE;

COMMENT ON COLUMN TB_INOUTVOICE.Inoutvoice_id IS '입출고전표 ID'; 
COMMENT ON COLUMN TB_INOUTVOICE.Inoutvoice_name IS '입출고 전표 이름'; 
COMMENT ON COLUMN TB_INOUTVOICE.Inoutvoice_type IS '입출고 전표 유형'; 
COMMENT ON COLUMN TB_INOUTVOICE.order_id IS '주문 ID'; 
COMMENT ON COLUMN TB_INOUTVOICE.worker_id IS '작업자 ID'; 
COMMENT ON COLUMN TB_INOUTVOICE.warehouse_id IS '창고 ID'; 
COMMENT ON COLUMN TB_INOUTVOICE.created_at IS '등록일'; 


-- 10. TB_APPROVAL_DOCUMENTS
CREATE TABLE TB_APPROVAL_DOCUMENTS (
    doc_id VARCHAR2(50) PRIMARY KEY,
    title VARCHAR2(255) NOT NULL,
    content CLOB,
    attach_file BLOB,
    attached_file_name VARCHAR2(255),
    emp_id VARCHAR2(20) NOT NULL,
    draft_date DATE NOT NULL,
    referencer_id VARCHAR2(20) NOT NULL,
    reviewer_id VARCHAR2(20) NOT NULL,
    approver_id VARCHAR2(20) NOT NULL,
    approval_status VARCHAR2(20) DEFAULT '발송' CHECK (approval_status IN ('발송', '검토중', '승인', '반려', '회수')),
    document_format VARCHAR2(100) NOT NULL,
    approval_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_approval_emp_id FOREIGN KEY (emp_id) REFERENCES TB_USER(empid)ON DELETE CASCADE
);

ALTER TABLE TB_APPROVAL_DOCUMENTS
ADD CONSTRAINT fk_approval_referencer_id FOREIGN KEY (referencer_id) REFERENCES TB_USER(empid) ON DELETE CASCADE;

ALTER TABLE TB_APPROVAL_DOCUMENTS
ADD CONSTRAINT fk_approval_reviewer_id FOREIGN KEY (reviewer_id) REFERENCES TB_USER(empid) ON DELETE CASCADE;

ALTER TABLE TB_APPROVAL_DOCUMENTS
ADD CONSTRAINT fk_approval_approver_id FOREIGN KEY (approver_id) REFERENCES TB_USER(empid) ON DELETE CASCADE;


COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.doc_id IS '문서 ID'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.title IS '문서 제목'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.content IS '문서 내용'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.attach_file IS '첨부 파일'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.attached_file_name IS '첨부 파일명';
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.emp_id IS '작성자 ID'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.draft_date IS '작성일';
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.referencer_id IS '참조자 ID'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.reviewer_id IS '검토자 ID'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.approver_id IS '결재자 ID'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.approval_status IS '결재 상태'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.document_format IS '문서 형식';
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.approval_date IS '결재일'; 


-- 11. TB_TRANSACTION_DOCUMENTS
CREATE TABLE TB_TRANSACTION_DOCUMENTS (
    tdoc_id VARCHAR2(20) PRIMARY KEY,
    doc_name VARCHAR2(200) NOT NULL,
    doc_type VARCHAR2(100) DEFAULT '입고계약서' NOT NULL,
    related_party_type VARCHAR2(200) DEFAULT '판매처' NOT NULL,
    related_party_id VARCHAR2(20) NOT NULL,
    uploaded_at DATE NOT NULL,
    uploaded_by VARCHAR2(20) NOT NULL,
    valid_until DATE,
    status VARCHAR2(100) DEFAULT '유효' NOT NULL,
    content CLOB,
    attached_file BLOB,
    attached_file_name VARCHAR2(255),
    
    CONSTRAINT ck_doc_type CHECK (doc_type IN ('입고계약서', '출고계약서', '납품확인서', '세금계산서', '영수증')),
    CONSTRAINT ck_related_party_type CHECK (related_party_type IN ('공급처', '판매처')),
    CONSTRAINT ck_status CHECK (status IN ('유효', '만료', '대기')),
    
    CONSTRAINT fk_transdoc_related_party_id FOREIGN KEY (related_party_id) REFERENCES TB_PARTNER(partner_id)ON DELETE CASCADE,
    CONSTRAINT fk_transdoc_uploaded_by FOREIGN KEY (uploaded_by) REFERENCES TB_USER(empid)ON DELETE CASCADE
);


COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.tdoc_id IS '문서 ID'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.doc_name IS '문서 이름'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.doc_type IS '문서 유형'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.related_party_type IS '관련 거래처 유형'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.related_party_id IS '관련 거래처 ID'; COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.uploaded_at IS '업로드 날짜'; COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.uploaded_by IS '작성자 사원번호'; COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.valid_until IS '유효 기간'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.status IS '문서 상태'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.content IS '문서 내용'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.attached_file IS '첨부 파일';
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.attached_file_name IS '첨부 파일명';


-- 12. TB_ROLE_GROUP
CREATE TABLE TB_ROLE_GROUP (
    role_group_id VARCHAR2(20) PRIMARY KEY,
    role_group_name VARCHAR2(50) NOT NULL,
    created_at DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN TB_ROLE_GROUP.role_group_id IS '역할 그룹 ID'; 
COMMENT ON COLUMN TB_ROLE_GROUP.role_group_name IS '역할 그룹 이름'; 
COMMENT ON COLUMN TB_ROLE_GROUP.created_at IS '생성일'; 


-- 13. TB_USER_ROLE
CREATE TABLE TB_USER_ROLE (
    user_id VARCHAR2(20),
    role_group_id VARCHAR2(20),
    CONSTRAINT pk_user_role PRIMARY KEY (user_id, role_group_id),
    CONSTRAINT fk_userrole_user_id FOREIGN KEY (user_id) REFERENCES TB_USER(empid)ON DELETE CASCADE,
    CONSTRAINT fk_userrole_role_group_id FOREIGN KEY (role_group_id) REFERENCES TB_ROLE_GROUP(role_group_id)ON DELETE CASCADE
);

COMMENT ON COLUMN TB_USER_ROLE.user_id IS '사용자 ID'; 
COMMENT ON COLUMN TB_USER_ROLE.role_group_id IS '역할 그룹 ID'; 


-- 14. TB_PERMISSION_CODE
CREATE TABLE TB_PERMISSION_CODE (
    permission_code VARCHAR2(50) PRIMARY KEY,
    permission_name VARCHAR2(100) NOT NULL,
    is_active CHAR(1) DEFAULT 'Y' CHECK (is_active IN ('Y', 'N'))
);

COMMENT ON COLUMN TB_PERMISSION_CODE.permission_code IS '권한 코드'; 
COMMENT ON COLUMN TB_PERMISSION_CODE.permission_name IS '권한 이름'; 
COMMENT ON COLUMN TB_PERMISSION_CODE.is_active IS '권한 활성화 여부 (Y/N)'; 


-- 15. TB_ROLE_PERMISSION
CREATE TABLE TB_ROLE_PERMISSION (
    role_group_id VARCHAR2(20),
    permission_code VARCHAR2(50),
    CONSTRAINT pk_role_permission PRIMARY KEY (role_group_id, permission_code),
    CONSTRAINT fk_roleperm_role_group_id FOREIGN KEY (role_group_id) REFERENCES TB_ROLE_GROUP(role_group_id)ON DELETE CASCADE,
    CONSTRAINT fk_roleperm_permission_code FOREIGN KEY (permission_code) REFERENCES TB_PERMISSION_CODE(permission_code)ON DELETE CASCADE
);

COMMENT ON COLUMN TB_ROLE_PERMISSION.role_group_id IS '역할 그룹 ID'; 
COMMENT ON COLUMN TB_ROLE_PERMISSION.permission_code IS '권한 코드';


-- 16. TB_NOTICE_BOARD
CREATE TABLE TB_NOTICE_BOARD (
    post_id NUMBER PRIMARY KEY,
    title VARCHAR2(200) NOT NULL,
    content CLOB NOT NULL,
    author VARCHAR2(20) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    view_count NUMBER DEFAULT 0,
    attached_file BLOB,
    attached_file_name VARCHAR2(255),
    CONSTRAINT fk_notice_author FOREIGN KEY (author) REFERENCES TB_USER(empid) ON DELETE CASCADE
);

COMMENT ON COLUMN TB_NOTICE_BOARD.post_id IS '게시물 ID'; 
COMMENT ON COLUMN TB_NOTICE_BOARD.title IS '게시물 제목'; 
COMMENT ON COLUMN TB_NOTICE_BOARD.content IS '게시물 내용'; 
COMMENT ON COLUMN TB_NOTICE_BOARD.author IS '작성자 ID'; 
COMMENT ON COLUMN TB_NOTICE_BOARD.created_at IS '작성일'; 
COMMENT ON COLUMN TB_NOTICE_BOARD.view_count IS '조회수'; 
COMMENT ON COLUMN TB_NOTICE_BOARD.attached_file IS '첨부 파일';
COMMENT ON COLUMN TB_NOTICE_BOARD.attached_file_name IS '첨부 파일명';


-- TRIGGER 

-- 등록 및 수정 날짜 자동 지정

-- TB_PRODUCT 
CREATE OR REPLACE TRIGGER trg_product_timestamp 
BEFORE INSERT OR UPDATE ON TB_PRODUCT
FOR EACH ROW BEGIN -- INSERT 시 created_at과 updated_at 설정 
IF INSERTING THEN 
:NEW.created_at := SYSDATE; 
:NEW.updated_at := SYSDATE; -- UPDATE 시 updated_at만 갱신 
ELSIF UPDATING THEN 
:NEW.updated_at := SYSDATE; -- created_at은 변경되지 않도록 기존 값 유지 
:NEW.created_at := :OLD.created_at; 
END IF; 
END; 
/


-- TB_STOCK_HISTORY 
CREATE OR REPLACE TRIGGER trg_stockhist_timestamp
BEFORE INSERT ON TB_STOCK_HISTORY
FOR EACH ROW
BEGIN
    :NEW.change_date := SYSDATE;
END;
/

-- 음수 재고 방지
CREATE OR REPLACE TRIGGER trg_warehouse_stock_validate
BEFORE INSERT OR UPDATE ON TB_WAREHOUSE_STOCK
FOR EACH ROW
BEGIN
    IF :NEW.stock < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, '재고는 음수일 수 없습니다.');
    END IF;
END;
/

-- 거래문서 유효/만료 자동변경
CREATE OR REPLACE TRIGGER trg_transaction_documents_status
BEFORE INSERT OR UPDATE ON TB_TRANSACTION_DOCUMENTS
FOR EACH ROW
BEGIN
    -- valid_until이 NULL이 아니고, SYSDATE를 지난 경우 status를 '만료'로 설정
    IF :NEW.valid_until IS NOT NULL AND :NEW.valid_until < SYSDATE THEN
        :NEW.status := '만료';
    -- valid_until이 SYSDATE 이후이고, status가 '만료'가 아닌 경우 '유효'로 설정
    ELSIF :NEW.valid_until IS NOT NULL AND :NEW.valid_until >= SYSDATE AND :NEW.status != '만료' THEN
        :NEW.status := '유효';
    -- valid_until이 NULL이거나, status가 이미 '대기'인 경우 변경하지 않음
    END IF;
END;
/

-- 1. TB_USER (30개: 기존 25개 + 부서별 부장 5개)
-- 중복 데이터 삭제
DELETE FROM TB_USER 
WHERE empid = 'EMP031' OR email = 'yskim@example.com' OR empno = '760515-1345678';

-- TB_USER 데이터 삽입 (EMP001~EMP030)
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP001', '김영희', '영업부', '사원', 'yhkim@example.com', '010-1234-5678', '900101-1234567', TO_DATE('2023-01-15', 'YYYY-MM-DD'), '서울시 강남구', 'hashed_pwd1', 'N', TO_DATE('2025-04-09', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP002', '이철수', '물류부', '대리', 'cslee@example.com', '010-9876-5432', '850215-2345678', TO_DATE('2022-06-01', 'YYYY-MM-DD'), '경기도 수원시', 'hashed_pwd2', 'N', TO_DATE('2025-04-10', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP003', '박민수', '경영지원부', '과장', 'mspark@example.com', '010-5588-6688', '870324-3456789', TO_DATE('2021-03-10', 'YYYY-MM-DD'), '인천시 부평구', 'hashed_pwd3', 'N', NULL, 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP004', '최지훈', '인사부', '사원', 'jhchoi@example.com', '010-7777-8888', '920505-1234567', TO_DATE('2023-07-20', 'YYYY-MM-DD'), '서울시 마포구', 'hashed_pwd4', 'N', TO_DATE('2025-04-12', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP005', '정수진', '개발부', '대리', 'sjjeong@example.com', '010-2222-3333', '880616-2345678', TO_DATE('2022-09-15', 'YYYY-MM-DD'), '경기도 성남시', 'hashed_pwd5', 'N', TO_DATE('2025-04-11', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP006', '한지민', '영업부', '사원', 'jmhan@example.com', '010-1111-2222', '910727-1234567', TO_DATE('2023-02-10', 'YYYY-MM-DD'), '서울시 서초구', 'hashed_pwd6', 'N', NULL, 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP007', '오세훈', '물류부', '사원', 'shoh@example.com', '010-3333-4444', '890818-2345678', TO_DATE('2022-11-05', 'YYYY-MM-DD'), '부산시 해운대구', 'hashed_pwd7', 'N', TO_DATE('2025-04-13', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP008', '윤서영', '경영지원부', '대리', 'syyoon@example.com', '010-5555-7777', '860909-3456789', TO_DATE('2021-08-20', 'YYYY-MM-DD'), '대구시 달서구', 'hashed_pwd8', 'N', TO_DATE('2025-04-14', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP009', '강태우', '인사부', '과장', 'twkang@example.com', '010-8888-9999', '830101-1234567', TO_DATE('2020-04-15', 'YYYY-MM-DD'), '서울시 강북구', 'hashed_pwd9', 'N', TO_DATE('2025-04-15', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP010', '서민재', '개발부', '사원', 'mjseo@example.com', '010-0000-1111', '940212-2345678', TO_DATE('2023-09-01', 'YYYY-MM-DD'), '경기도 고양시', 'hashed_pwd10', 'N', NULL, 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP011', '김도현', '영업부', '대리', 'dhkim@example.com', '010-2222-5555', '870303-1234567', TO_DATE('2022-03-20', 'YYYY-MM-DD'), '서울시 동작구', 'hashed_pwd11', 'N', TO_DATE('2025-04-16', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP012', '이수민', '물류부', '사원', 'smlee@example.com', '010-6666-7777', '910414-2345678', TO_DATE('2023-05-10', 'YYYY-MM-DD'), '인천시 남동구', 'hashed_pwd12', 'N', TO_DATE('2025-04-17', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP013', '박지영', '경영지원부', '사원', 'jypark@example.com', '010-8888-0000', '880525-3456789', TO_DATE('2022-07-15', 'YYYY-MM-DD'), '서울시 관악구', 'hashed_pwd13', 'N', NULL, 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP014', '최윤아', '인사부', '대리', 'yachoi@example.com', '010-1111-3333', '850606-1234567', TO_DATE('2021-12-01', 'YYYY-MM-DD'), '경기도 안양시', 'hashed_pwd14', 'N', TO_DATE('2025-04-18', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP015', '정민호', '개발부', '과장', 'mhjeong@example.com', '010-4444-5555', '820717-2345678', TO_DATE('2020-06-20', 'YYYY-MM-DD'), '서울시 은평구', 'hashed_pwd15', 'N', TO_DATE('2025-04-19', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP016', '한지우', '영업부', '사원', 'jwhan@example.com', '010-6666-8888', '930808-1234567', TO_DATE('2023-08-10', 'YYYY-MM-DD'), '부산시 수영구', 'hashed_pwd16', 'N', NULL, 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP017', '오세진', '물류부', '대리', 'sjoh@example.com', '010-9999-0000', '860919-2345678', TO_DATE('2022-01-15', 'YYYY-MM-DD'), '대구시 북구', 'hashed_pwd17', 'N', TO_DATE('2025-04-20', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP018', '윤하늘', '경영지원부', '사원', 'hnyoon@example.com', '010-2222-6666', '890101-3456789', TO_DATE('2022-10-05', 'YYYY-MM-DD'), '서울시 강동구', 'hashed_pwd18', 'N', TO_DATE('2025-04-21', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP019', '강민서', '인사부', '사원', 'mskang@example.com', '010-7777-9999', '910202-1234567', TO_DATE('2023-03-20', 'YYYY-MM-DD'), '경기도 용인시', 'hashed_pwd19', 'N', NULL, 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP020', '서지훈', '개발부', '대리', 'jhseo@example.com', '010-0000-2222', '880313-2345678', TO_DATE('2022-04-10', 'YYYY-MM-DD'), '서울시 성북구', 'hashed_pwd20', 'N', TO_DATE('2025-04-22', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP021', '김예린', '영업부', '사원', 'yrkim@example.com', '010-3333-5555', '920424-1234567', TO_DATE('2023-06-15', 'YYYY-MM-DD'), '인천시 서구', 'hashed_pwd21', 'N', TO_DATE('2025-04-23', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP022', '이하준', '물류부', '사원', 'hjlee@example.com', '010-6666-9999', '870505-2345678', TO_DATE('2022-08-20', 'YYYY-MM-DD'), '서울시 양천구', 'hashed_pwd22', 'N', NULL, 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP023', '박소연', '경영지원부', '대리', 'sypark@example.com', '010-1111-4444', '840616-3456789', TO_DATE('2021-05-10', 'YYYY-MM-DD'), '경기도 파주시', 'hashed_pwd23', 'N', TO_DATE('2025-04-24', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP024', '최동혁', '물류부', '과장', 'dhchoi@example.com', '010-5555-8888', '810727-1234567', TO_DATE('2020-09-15', 'YYYY-MM-DD'), '서울시 종로구', 'hashed_pwd24', 'N', TO_DATE('2025-04-25', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP025', '정유진', '개발부', '사원', 'yjjeong@example.com', '010-9999-2222', '930808-2345678', TO_DATE('2023-11-01', 'YYYY-MM-DD'), '부산시 금정구', 'hashed_pwd25', 'N', TO_DATE('2025-04-26', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP026', '김태형', '영업부', '부장', 'thkim@example.com', '010-1234-9999', '800101-1234567', TO_DATE('2020-01-10', 'YYYY-MM-DD'), '서울시 송파구', 'hashed_pwd26', 'N', TO_DATE('2025-04-27', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP027', '이정훈', '물류부', '부장', 'jhlee@example.com', '010-5678-0000', '790212-2345678', TO_DATE('2019-06-15', 'YYYY-MM-DD'), '경기도 부천시', 'hashed_pwd27', 'N', TO_DATE('2025-04-28', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP028', '박혜진', '경영지원부', '부장', 'hjpark@example.com', '010-9012-3333', '780323-2456789', TO_DATE('2018-03-20', 'YYYY-MM-DD'), '서울시 중구', 'hashed_pwd28', 'N', NULL, 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP029', '최민규', '인사부', '부장', 'mgchoi@example.com', '010-3456-7777', '770404-1234567', TO_DATE('2017-09-10', 'YYYY-MM-DD'), '서울시 강서구', 'hashed_pwd29', 'N', TO_DATE('2025-04-29', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP030', '정혁수', '개발부', '부장', 'hsjeong@example.com', '010-7890-1111', '760515-1325678', TO_DATE('2016-12-05', 'YYYY-MM-DD'), '경기도 분당시', 'hashed_pwd30', 'Y', TO_DATE('2025-04-30', 'YYYY-MM-DD'), 'Y');
-- EMP031 삭제 및 삽입
DELETE FROM TB_USER WHERE empid = 'EMP031';
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP031', '김영수', NULL, '이사', 'yskim@example.com', '010-5555-6666', '760515-1345678', TO_DATE('2016-12-05', 'YYYY-MM-DD'), '서울시 강남구', 'hashed_pwd31', 'N', TO_DATE('2025-04-30', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP032', '박지현', '영업부', '과장', 'jhpark@example.com', '010-7000-8888', '880323-2345678', TO_DATE('2018-03-15', 'YYYY-MM-DD'), '서울시 마포구', 'hashed_pwd32', 'N', TO_DATE('2025-05-01', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP033', '이민호', '물류부', '과장', 'mhlee@example.com', '010-9459-0000', '900612-1345678', TO_DATE('2018-06-01', 'YYYY-MM-DD'), '경기도 과천시', 'hashed_pwd33', 'N', TO_DATE('2025-05-02', 'YYYY-MM-DD'), 'Y');



-- 2. TB_PARTNER (15개)
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART001', '공급처', 'ABC물산', 'EMP001', '김영희', '010-1234-5678', 'yhkim@example.com', '서울시 중구', '123-45-67890', '최영수', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART002', '판매처', 'XYZ상사', 'EMP002', '이철수', '010-9876-5432', 'cslee@example.com', '부산시 해운대구', '987-65-43210', '김지영', '유한회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART003', '공급처', 'DEF산업', 'EMP004', '최지훈', '010-7777-8888', 'jhchoi@example.com', '1234 Tech Drive, Silicon Valley, CA, USA', 'US123456789', 'Emma Johnson', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART004', '판매처', 'GHI무역', 'EMP004', '최지훈', '010-7777-8888', 'jhchoi@example.com', '25 Oxford Street, London, UK', 'UK654321789', 'James Wilson', '유한회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART005', '공급처', 'JKL상사', 'EMP005', '정수진', '010-2222-3333', 'sjjeong@example.com', '대구시 달서구', '999-11-22233', '김태우', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART006', '판매처', 'MNO물류', 'EMP006', '한지민', '010-1111-2222', 'jmhan@example.com', '서울시 서초구', '444-55-66677', '박민수', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART007', '공급처', 'PQR전자', 'EMP007', '오세훈', '010-3333-4444', 'shoh@example.com', '1-2-3 Shibuya, Tokyo, Japan', 'JP987654321', 'Yuki Sato', '유한회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART008', '판매처', 'STU무역', 'EMP008', '윤서영', '010-5555-7777', 'syyoon@example.com', '456 George Street, Sydney, Australia', 'AU789456123', 'Sophie Taylor', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART009', '공급처', 'VWX산업', 'EMP009', '강태우', '010-8888-9999', 'twkang@example.com', '서울시 강북구', '666-77-88899', '서민재', '유한회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART010', '판매처', 'YZA물산', 'EMP010', '서민재', '010-0000-1111', 'mjseo@example.com', '경기도 고양시', '111-44-55566', '김도현', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART011', '공급처', 'BCD전자', 'EMP011', '김도현', '010-2222-5555', 'dhkim@example.com', '45 Industriestraße, Berlin, Germany', 'DE456789123', 'Lukas Schmidt', '유한회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART012', '판매처', 'EFG무역', 'EMP012', '이수민', '010-6666-7777', 'smlee@example.com', '789 Yonge Street, Toronto, Canada', 'CA123789456', 'Michael Brown', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART013', '공급처', 'HIJ물류', 'EMP013', '박지영', '010-8888-0000', 'jypark@example.com', '서울시 관악구', '333-55-77788', '최윤아', '유한회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART014', '판매처', 'KLM전자', 'EMP014', '최윤아', '010-1111-3333', 'yachoi@example.com', '경기도 안양시', '777-11-22233', '정민호', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART015', '공급처', 'NOP산업', 'EMP015', '정민호', '010-4444-5555', 'mhjeong@example.com', '서울시 은평구', '222-66-88899', '한지우', '유한회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART016', '공급처', 'XYZ테크', 'EMP031', '김영수', '010-5555-6666', 'yskim@example.com', '서울시 강남구', '333-77-99900', '김영수', '주식회사', 'Active');



-- 3. TB_WAREHOUSE (12개)
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH001', 'OWN', '본사창고', '서울시 송파구', 500, 'EMP002', '이철수', '010-9876-5432', 'cslee@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH002', '3PL', '경유창고', '경북 포항시', 360, 'EMP014', '최윤아', '010-1111-3333', 'yachoi@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH003', '3PL', '불량창고', '제주시 서귀포', 360, 'EMP015', '정민호', '010-4444-5555', 'mhjeong@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH004', '3PL', '부산창고', '부산시 사상구', 300, 'EMP003', '박민수', '010-5588-6688', 'mspark@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH005', 'OWN', '인천창고', '인천시 연수구', 400, 'EMP004', '최지훈', '010-7777-8888', 'jhchoi@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH006', '3PL', '대구창고', '대구시 수성구', 350, 'EMP005', '정수진', '010-2222-3333', 'sjjeong@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH007', 'OWN', '광주창고', '광주시 북구', 450, 'EMP006', '한지민', '010-1111-2222', 'jmhan@example.com');


-- 4. TB_PRODUCT 샘플 데이터 30개 삽입 (자재 15개, 완제품 15개)
-- TB_PRODUCT 샘플 데이터 30개 삽입 (부품 15개, 완제품 15개)
-- 부품: partner_id 필수, 전자제품 부품

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD001', 'PART001', '회로기판', '4층 PCB', '부품', 5000.00, 7500.00, 'ElectroCorp', 'South Korea', '전자부품', 100, NULL, TO_DATE('2024-05-01', 'YYYY-MM-DD'), TO_DATE('2024-05-01', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD002', 'PART003', '반도체 칩', '32bit', '부품', 3000.00, 4500.00, 'ChipTech', 'USA', '전자부품', 150, NULL, TO_DATE('2024-05-02', 'YYYY-MM-DD'), TO_DATE('2024-05-02', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD003', 'PART005', '커넥터', 'USB-C', '부품', 1000.00, 1500.00, 'ConnectInc', 'China', '전자부품', 200, NULL, TO_DATE('2024-05-03', 'YYYY-MM-DD'), TO_DATE('2024-05-03', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD004', 'PART007', '저항기', '10kΩ', '부품', 500.00, 800.00, 'ResistCo', 'Japan', '전자부품', 500, NULL, TO_DATE('2024-05-04', 'YYYY-MM-DD'), TO_DATE('2024-05-04', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD005', 'PART009', '콘덴서', '100μF', '부품', 700.00, 1000.00, 'CapacitorLtd', 'Taiwan', '전자부품', 300, NULL, TO_DATE('2024-05-05', 'YYYY-MM-DD'), TO_DATE('2024-05-05', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD006', 'PART011', '다이오드', '1N4007', '부품', 300.00, 500.00, 'DiodeTech', 'Germany', '전자부품', 400, NULL, TO_DATE('2024-05-06', 'YYYY-MM-DD'), TO_DATE('2024-05-06', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD007', 'PART013', '트랜지스터', 'NPN', '부품', 600.00, 900.00, 'TransistorInc', 'USA', '전자부품', 250, NULL, TO_DATE('2024-05-07', 'YYYY-MM-DD'), TO_DATE('2024-05-07', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD008', 'PART015', 'LED', '3mm 적색', '부품', 200.00, 300.00, 'LEDLightCo', 'China', '전자부품', 600, NULL, TO_DATE('2024-05-08', 'YYYY-MM-DD'), TO_DATE('2024-05-08', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD009', 'PART001', '센서', '온도', '부품', 2000.00, 3000.00, 'SensorTech', 'South Korea', '전자부품', 150, NULL, TO_DATE('2024-05-09', 'YYYY-MM-DD'), TO_DATE('2024-05-09', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD010', 'PART003', '릴레이', '5V', '부품', 1500.00, 2200.00, 'RelayCorp', 'Japan', '전자부품', 200, NULL, TO_DATE('2024-05-10', 'YYYY-MM-DD'), TO_DATE('2024-05-10', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD011', 'PART005', '마이크로컨트롤러', '8bit', '부품', 4000.00, 6000.00, 'MicroChip', 'USA', '전자부품', 100, NULL, TO_DATE('2024-05-11', 'YYYY-MM-DD'), TO_DATE('2024-05-11', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD012', 'PART007', '배터리 셀', '3.7V', '부품', 3000.00, 4500.00, 'BatteryTech', 'China', '전자부품', 120, NULL, TO_DATE('2024-05-12', 'YYYY-MM-DD'), TO_DATE('2024-05-12', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD013', 'PART009', 'LCD 패널', '5인치', '부품', 10000.00, 15000.00, 'DisplayCo', 'South Korea', '전자부품', 80, NULL, TO_DATE('2024-05-13', 'YYYY-MM-DD'), TO_DATE('2024-05-13', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD014', 'PART011', '케이블', 'HDMI', '부품', 2000.00, 3000.00, 'CableInc', 'Taiwan', '전자부품', 150, NULL, TO_DATE('2024-05-14', 'YYYY-MM-DD'), TO_DATE('2024-05-14', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD015', 'PART013', '인쇄회로기판', '6층 PCB', '부품', 6000.00, 9000.00, 'PCBCorp', 'Japan', '전자부품', 90, NULL, TO_DATE('2024-05-15', 'YYYY-MM-DD'), TO_DATE('2024-05-15', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD016', 'PART016', '노트북', '16GB RAM', '완제품', 800000.00, 1200000.00, 'TechTrend', 'South Korea', '전자제품', 10, NULL, TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-01', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD017', 'PART016', '스마트폰', '128GB', '완제품', 600000.00, 900000.00, 'MobileTech', 'China', '전자제품', 15, NULL, TO_DATE('2024-06-02', 'YYYY-MM-DD'), TO_DATE('2024-06-02', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD018', 'PART016', '태블릿', '64GB', '완제품', 400000.00, 600000.00, 'TabletCo', 'USA', '전자제품', 20, NULL, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD019', 'PART016', '헤드셋', '무선', '완제품', 100000.00, 150000.00, 'AudioTech', 'Japan', '전자제품', 30, NULL, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD020', 'PART016', '모니터', '27인치', '완제품', 200000.00, 300000.00, 'DisplayTech', 'South Korea', '전자제품', 15, NULL, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD021', 'PART016', '키보드', '기계식', '완제품', 80000.00, 120000.00, 'InputCo', 'China', '전자제품', 25, NULL, TO_DATE('2024-06-06', 'YYYY-MM-DD'), TO_DATE('2024-06-06', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD022', 'PART016', '마우스', '무선', '완제품', 50000.00, 80000.00, 'InputCo', 'China', '전자제품', 20, NULL, TO_DATE('2024-06-07', 'YYYY-MM-DD'), TO_DATE('2024-06-07', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD023', 'PART016', '외장하드', '1TB', '완제품', 120000.00, 180000.00, 'StorageTech', 'Taiwan', '전자제품', 10, NULL, TO_DATE('2024-06-08', 'YYYY-MM-DD'), TO_DATE('2024-06-08', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD024', 'PART016', 'USB드라이브', '64GB', '완제품', 20000.00, 35000.00, 'StorageTech', 'Taiwan', '전자제품', 50, NULL, TO_DATE('2024-06-09', 'YYYY-MM-DD'), TO_DATE('2024-06-09', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD025', 'PART016', '웹캠', '1080p', '완제품', 70000.00, 110000.00, 'VisionTech', 'China', '전자제품', 15, NULL, TO_DATE('2024-06-10', 'YYYY-MM-DD'), TO_DATE('2024-06-10', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD026', 'PART016', 'TV', '55인치', '완제품', 1000000.00, 1500000.00, 'HomeTech', 'South Korea', '가전제품', 10, NULL, TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-01', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD027', 'PART016', '냉장고', '500L', '완제품', 1200000.00, 1800000.00, 'ApplianceCo', 'Japan', '가전제품', 8, NULL, TO_DATE('2024-07-02', 'YYYY-MM-DD'), TO_DATE('2024-07-02', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD028', 'PART016', '에어컨', '2HP', '완제품', 800000.00, 1200000.00, 'CoolTech', 'China', '가전제품', 12, NULL, TO_DATE('2024-07-03', 'YYYY-MM-DD'), TO_DATE('2024-07-03', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD029', 'PART016', '세탁기', '15kg', '완제품', 700000.00, 1000000.00, 'CleanTech', 'South Korea', '가전제품', 15, NULL, TO_DATE('2024-07-04', 'YYYY-MM-DD'), TO_DATE('2024-07-04', 'YYYY-MM-DD'));

INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, product_type, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock, product_image, created_at, updated_at)
VALUES ('PROD030', 'PART016', '청소기', '무선', '완제품', 200000.00, 300000.00, 'CleanTech', 'South Korea', '가전제품', 20, NULL, TO_DATE('2024-07-05', 'YYYY-MM-DD'), TO_DATE('2024-07-05', 'YYYY-MM-DD'));


-- TB_WAREHOUSE_STOCK 샘플 데이터 30개 삽입
-- 부품 (PROD001~PROD015): 창고 WH001 ~ WH006
-- 기존 데이터: stock 수량 2배 증가
-- WH002
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH002', 'PROD003', 30); -- 커넥터, safe_stock=200, normal_stock=200*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH002', 'PROD004', 25); -- 저항기, safe_stock=500, normal_stock=500*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH002', 'PROD014', 20); -- 케이블, safe_stock=150, normal_stock=150*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH002', 'PROD020', 15); -- 모니터, safe_stock=15, normal_stock=15*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH002', 'PROD021', 10); -- 키보드, safe_stock=25, normal_stock=25*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH002', 'PROD030', 35); -- 청소기, safe_stock=20, normal_stock=20*6

-- WH003
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH003', 'PROD005', 40); -- 콘덴서, safe_stock=300, normal_stock=300*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH003', 'PROD006', 30); -- 다이오드, safe_stock=400, normal_stock=400*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH003', 'PROD015', 25); -- 인쇄회로기판, safe_stock=90, normal_stock=90*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH003', 'PROD018', 20); -- 태블릿, safe_stock=20, normal_stock=20*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH003', 'PROD022', 15); -- 마우스, safe_stock=20, normal_stock=20*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH003', 'PROD023', 10); -- 외장하드, safe_stock=10, normal_stock=10*6

-- WH001
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD001', 1000); -- 회로기판, safe_stock=100, normal_stock=100*10

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD002', 1200); -- 반도체 칩, safe_stock=150, normal_stock=150*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD003', 1600); -- 커넥터, safe_stock=200, normal_stock=200*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD004', 4000); -- 저항기, safe_stock=500, normal_stock=500*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD005', 2400); -- 콘덴서, safe_stock=300, normal_stock=300*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD006', 3200); -- 다이오드, safe_stock=400, normal_stock=400*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD007', 2000); -- 트랜지스터, safe_stock=250, normal_stock=250*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD008', 4800); -- LED, safe_stock=600, normal_stock=600*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD009', 1200); -- 센서, safe_stock=150, normal_stock=150*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD010', 1600); -- 릴레이, safe_stock=200, normal_stock=200*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD011', 800); -- 마이크로컨트롤러, safe_stock=100, normal_stock=100*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD012', 960); -- 배터리 셀, safe_stock=120, normal_stock=120*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD013', 640); -- LCD 패널, safe_stock=80, normal_stock=80*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD014', 1200); -- 케이블, safe_stock=150, normal_stock=150*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD015', 720); -- 인쇄회로기판, safe_stock=90, normal_stock=90*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD016', 60); -- 노트북, safe_stock=10, normal_stock=10*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD017', 90); -- 스마트폰, safe_stock=15, normal_stock=15*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD018', 120); -- 태블릿, safe_stock=20, normal_stock=20*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD019', 180); -- 헤드셋, safe_stock=30, normal_stock=30*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD020', 90); -- 모니터, safe_stock=15, normal_stock=15*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD021', 150); -- 키보드, safe_stock=25, normal_stock=25*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id,product_id, stock)
VALUES ('WH001', 'PROD022', 120); -- 마우스, safe_stock=20, normal_stock=20*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD023', 60); -- 외장하드, safe_stock=10, normal_stock=10*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD024', 300); -- USB드라이브, safe_stock=50, normal_stock=50*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD025', 90); -- 웹캠, safe_stock=15, normal_stock=15*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD026', 60); -- TV, safe_stock=10, normal_stock=10*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD027', 48); -- 냉장고, safe_stock=8, normal_stock=8*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD028', 72); -- 에어컨, safe_stock=12, normal_stock=12*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD029', 90); -- 세탁기, safe_stock=15, normal_stock=15*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH001', 'PROD030', 120); -- 청소기, safe_stock=20, normal_stock=20*6

-- WH004
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH004', 'PROD007', 2000); -- 트랜지스터, safe_stock=250, normal_stock=250*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH004', 'PROD008', 4800); -- LED, safe_stock=600, normal_stock=600*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH004', 'PROD019', 180); -- 헤드셋, safe_stock=30, normal_stock=30*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH004', 'PROD024', 300); -- USB드라이브, safe_stock=50, normal_stock=50*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH004', 'PROD025', 90); -- 웹캠, safe_stock=15, normal_stock=15*6

-- WH005
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH005', 'PROD001', 1000); -- 회로기판, safe_stock=100, normal_stock=100*10

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH005', 'PROD002', 1200); -- 반도체 칩, safe_stock=150, normal_stock=150*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH005', 'PROD009', 1200); -- 센서, safe_stock=150, normal_stock=150*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH005', 'PROD010', 1600); -- 릴레이, safe_stock=200, normal_stock=200*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH005', 'PROD026', 60); -- TV, safe_stock=10, normal_stock=10*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH005', 'PROD027', 48); -- 냉장고, safe_stock=8, normal_stock=8*6

-- WH006
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH006', 'PROD011', 800); -- 마이크로컨트롤러, safe_stock=100, normal_stock=100*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH006', 'PROD012', 960); -- 배터리 셀, safe_stock=120, normal_stock=120*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH006', 'PROD013', 640); -- LCD 패널, safe_stock=80, normal_stock=80*8

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH006', 'PROD029', 90); -- 세탁기, safe_stock=15, normal_stock=15*6

-- WH007
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH007', 'PROD016', 60); -- 노트북, safe_stock=10, normal_stock=10*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH007', 'PROD017', 90); -- 스마트폰, safe_stock=15, normal_stock=15*6

INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
VALUES ('WH007', 'PROD028', 72); -- 에어컨, safe_stock=12, normal_stock=12*6


-- 6. TB_ORDERS 샘플 데이터 30개 삽입 (발주 15개, 수주 15개)
-- TB_ORDERS 샘플 데이터 30개 삽입 (발주 15개, 수주 15개)
-- 발주 (부품, PROD001~PROD015): 원자재 입고, partner_id 필수 (PART001, PART003, PART005, PART007, PART009, PART011, PART013, PART015)
-- 완료: 2024-08-01 ~ 2024-10-30 (1~9)
-- 날짜 오래된 순으로 정렬된 INSERT 문 (created_at 기준)
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART001', 'PROD001', 150, '발주', '완료', TO_DATE('2024-08-01', 'YYYY-MM-DD')); -- 회로기판

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART002', 'PROD016', 10, '수주', '완료', TO_DATE('2024-08-02', 'YYYY-MM-DD')); -- 노트북

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART003', 'PROD002', 180, '발주', '완료', TO_DATE('2024-08-15', 'YYYY-MM-DD')); -- 반도체 칩

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART004', 'PROD017', 15, '수주', '완료', TO_DATE('2024-08-16', 'YYYY-MM-DD')); -- 스마트폰

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART005', 'PROD003', 200, '발주', '완료', TO_DATE('2024-09-01', 'YYYY-MM-DD')); -- 커넥터

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART006', 'PROD018', 20, '수주', '완료', TO_DATE('2024-09-02', 'YYYY-MM-DD')); -- 태블릿

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART007', 'PROD004', 500, '발주', '완료', TO_DATE('2024-09-15', 'YYYY-MM-DD')); -- 저항기

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART008', 'PROD019', 30, '수주', '완료', TO_DATE('2024-09-16', 'YYYY-MM-DD')); -- 헤드셋

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART009', 'PROD005', 300, '발주', '취소', TO_DATE('2024-09-30', 'YYYY-MM-DD')); -- 콘덴서

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART010', 'PROD020', 15, '수주', '완료', TO_DATE('2024-10-01', 'YYYY-MM-DD')); -- 모니터

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART011', 'PROD006', 400, '발주', '완료', TO_DATE('2024-10-01', 'YYYY-MM-DD')); -- 다이오드

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART013', 'PROD007', 250, '발주', '완료', TO_DATE('2024-10-10', 'YYYY-MM-DD')); -- 트랜지스터

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART012', 'PROD021', 25, '수주', '완료', TO_DATE('2024-10-11', 'YYYY-MM-DD')); -- 키보드

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART013', 'PROD015', 90, '발주', '취소', TO_DATE('2024-10-15', 'YYYY-MM-DD')); -- 인쇄회로기판

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART015', 'PROD008', 600, '발주', '완료', TO_DATE('2024-10-20', 'YYYY-MM-DD')); -- LED

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART014', 'PROD022', 20, '수주', '완료', TO_DATE('2024-10-21', 'YYYY-MM-DD')); -- 마우스

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART002', 'PROD023', 10, '수주', '완료', TO_DATE('2024-10-25', 'YYYY-MM-DD')); -- 외장하드

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART004', 'PROD024', 50, '수주', '완료', TO_DATE('2024-10-30', 'YYYY-MM-DD')); -- USB드라이브

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART001', 'PROD009', 150, '발주', '완료', TO_DATE('2024-10-30', 'YYYY-MM-DD')); -- 센서

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART003', 'PROD010', 200, '발주', '처리중', TO_DATE('2024-11-01', 'YYYY-MM-DD')); -- 릴레이

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART006', 'PROD025', 15, '수주', '처리중', TO_DATE('2024-11-10', 'YYYY-MM-DD')); -- 웹캠

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART005', 'PROD011', 100, '발주', '처리중', TO_DATE('2024-11-15', 'YYYY-MM-DD')); -- 마이크로컨트롤러

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART008', 'PROD026', 10, '수주', '처리중', TO_DATE('2024-12-01', 'YYYY-MM-DD')); -- TV

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART007', 'PROD012', 120, '발주', '처리중', TO_DATE('2024-12-01', 'YYYY-MM-DD')); -- 배터리 셀

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART010', 'PROD027', 8, '수주', '처리중', TO_DATE('2024-12-15', 'YYYY-MM-DD')); -- 냉장고

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART009', 'PROD013', 80, '발주', '접수', TO_DATE('2025-01-01', 'YYYY-MM-DD')); -- LCD 패널

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART012', 'PROD028', 12, '수주', '접수', TO_DATE('2025-01-15', 'YYYY-MM-DD')); -- 에어컨

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART011', 'PROD014', 150, '발주', '접수', TO_DATE('2025-02-01', 'YYYY-MM-DD')); -- 케이블

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART014', 'PROD029', 15, '수주', '접수', TO_DATE('2025-03-01', 'YYYY-MM-DD')); -- 세탁기

INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, order_type, order_status, created_at)
VALUES ('ORD' || LPAD(seq_orders.NEXTVAL, 3, '0'), 'PART002', 'PROD030', 20, '수주', '접수', TO_DATE('2025-04-01', 'YYYY-MM-DD')); -- 청소기




-- 8. TB_ORDER_STATUS_HISTORY 샘플 데이터 30개 삽입
-- TB_ORDER_STATUS_HISTORY 샘플 데이터 삽입 (85행)
-- TB_ORDER_STATUS_HISTORY 데이터 (order_id를 TB_ORDERS와 연동)
-- ORD001 (회로기판, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD001', NULL, '접수', TO_DATE('2024-08-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD001', '접수', '처리중', TO_DATE('2024-08-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD001', '처리중', '완료', TO_DATE('2024-08-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV001, DOC001 승인

-- ORD002 (노트북, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD002', NULL, '접수', TO_DATE('2024-08-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD002', '접수', '처리중', TO_DATE('2024-08-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD002', '처리중', '완료', TO_DATE('2024-08-02 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV016, DOC002 승인

-- ORD003 (반도체 칩, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD003', NULL, '접수', TO_DATE('2024-08-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD003', '접수', '처리중', TO_DATE('2024-08-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD003', '처리중', '완료', TO_DATE('2024-08-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV002

-- ORD004 (스마트폰, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD004', NULL, '접수', TO_DATE('2024-08-16 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD004', '접수', '처리중', TO_DATE('2024-08-16 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD004', '처리중', '완료', TO_DATE('2024-08-16 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV017

-- ORD005 (커넥터, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD005', NULL, '접수', TO_DATE('2024-09-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD005', '접수', '처리중', TO_DATE('2024-09-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD005', '처리중', '완료', TO_DATE('2024-09-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV003, DOC003 승인

-- ORD006 (태블릿, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD006', NULL, '접수', TO_DATE('2024-09-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD006', '접수', '처리중', TO_DATE('2024-09-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD006', '처리중', '완료', TO_DATE('2024-09-02 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV018, DOC004 승인

-- ORD007 (저항기, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD007', NULL, '접수', TO_DATE('2024-09-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD007', '접수', '처리중', TO_DATE('2024-09-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD007', '처리중', '완료', TO_DATE('2024-09-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV004

-- ORD008 (헤드셋, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD008', NULL, '접수', TO_DATE('2024-09-16 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD008', '접수', '처리중', TO_DATE('2024-09-16 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD008', '처리중', '완료', TO_DATE('2024-09-16 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV019

-- ORD009 (콘덴서, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD009', NULL, '접수', TO_DATE('2024-09-30 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD009', '접수', '처리중', TO_DATE('2024-09-30 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD009', '처리중', '완료', TO_DATE('2024-09-30 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV005, DOC005 반려

-- ORD010 (모니터, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD010', NULL, '접수', TO_DATE('2024-10-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD010', '접수', '처리중', TO_DATE('2024-10-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD010', '처리중', '완료', TO_DATE('2024-10-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV020, DOC006 승인

-- ORD011 (다이오드, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD011', NULL, '접수', TO_DATE('2024-10-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD011', '접수', '처리중', TO_DATE('2024-10-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD011', '처리중', '완료', TO_DATE('2024-10-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV006

-- ORD012 (트랜지스터, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD012', NULL, '접수', TO_DATE('2024-10-10 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD012', '접수', '처리중', TO_DATE('2024-10-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD012', '처리중', '완료', TO_DATE('2024-10-10 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV007, DOC008 승인

-- ORD013 (키보드, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD013', NULL, '접수', TO_DATE('2024-10-11 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD013', '접수', '처리중', TO_DATE('2024-10-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD013', '처리중', '완료', TO_DATE('2024-10-11 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV021

-- ORD014 (인쇄회로기판, 취소)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD014', NULL, '접수', TO_DATE('2024-10-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD014', '접수', '취소', TO_DATE('2024-10-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- DOC005 반려

-- ORD015 (LED, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD015', NULL, '접수', TO_DATE('2024-10-20 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD015', '접수', '처리중', TO_DATE('2024-10-20 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD015', '처리중', '완료', TO_DATE('2024-10-20 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV008

-- ORD016 (마우스, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD016', NULL, '접수', TO_DATE('2024-10-21 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD016', '접수', '처리중', TO_DATE('2024-10-21 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD016', '처리중', '완료', TO_DATE('2024-10-21 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV022

-- ORD017 (외장하드, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD017', NULL, '접수', TO_DATE('2024-10-25 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD017', '접수', '처리중', TO_DATE('2024-10-25 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD017', '처리중', '완료', TO_DATE('2024-10-25 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV023

-- ORD018 (USB드라이브, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD018', NULL, '접수', TO_DATE('2024-10-30 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD018', '접수', '처리중', TO_DATE('2024-10-30 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD018', '처리중', '완료', TO_DATE('2024-10-30 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV024

-- ORD019 (센서, 완료)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD019', NULL, '접수', TO_DATE('2024-10-30 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD019', '접수', '처리중', TO_DATE('2024-10-30 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD019', '처리중', '완료', TO_DATE('2024-10-30 15:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV009, DOC013 승인

-- ORD020 (릴레이, 처리중)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD020', NULL, '접수', TO_DATE('2024-11-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD020', '접수', '처리중', TO_DATE('2024-11-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- 입출고 미완료

-- ORD021 (웹캠, 처리중)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD021', NULL, '접수', TO_DATE('2024-11-10 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD021', '접수', '처리중', TO_DATE('2024-11-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- 입출고 미완료

-- ORD022 (마이크로컨트롤러, 처리중)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD022', NULL, '접수', TO_DATE('2024-11-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD022', '접수', '처리중', TO_DATE('2024-11-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- 입출고 미완료, DOC018 대기

-- ORD023 (TV, 처리중)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD023', NULL, '접수', TO_DATE('2024-12-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD023', '접수', '처리중', TO_DATE('2024-12-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- 입출고 미완료

-- ORD024 (배터리 셀, 처리중)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD024', NULL, '접수', TO_DATE('2024-12-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD024', '접수', '처리중', TO_DATE('2024-12-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- 입출고 미완료

-- ORD025 (냉장고, 처리중)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD025', NULL, '접수', TO_DATE('2024-12-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD025', '접수', '처리중', TO_DATE('2024-12-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- 입출고 미완료

-- ORD026 (LCD 패널, 접수)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD026', NULL, '접수', TO_DATE('2025-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- ORD027 (에어컨, 접수)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD027', NULL, '접수', TO_DATE('2025-01-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- ORD028 (케이블, 접수)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD028', NULL, '접수', TO_DATE('2025-02-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- ORD029 (세탁기, 접수)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD029', NULL, '접수', TO_DATE('2025-03-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- ORD030 (청소기, 접수)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_order_status, order_status, status_change_date)
VALUES (seq_order_status_history.NEXTVAL, 'ORD030', NULL, '접수', TO_DATE('2025-04-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));



-- 9. TB_INOUTVOICE 샘플 데이터 30개 삽입 (입고 15개, 출고 15개)
-- TB_INOUTVOICE 샘플 데이터 30개 삽입 (입고 15개, 출고 15개)
-- TB_INOUTVOICE에 INV001~INV030 삽입 (외래 키 제약 충족)

-- 트리거 비활성화
--ALTER TRIGGER trg_inoutvoice DISABLE;

-- TB_INOUTVOICE 데이터 (created_at 기준 오래된 순서대로 Inoutvoice_id 재할당)
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_회로기판_1', '입고', 'ORD001', 'EMP001', 'WH001', TO_DATE('2024-08-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV001, ORD001, PROD001

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_노트북_16', '출고', 'ORD002', 'EMP001', 'WH007', TO_DATE('2024-08-02 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV002, ORD002, PROD016

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_반도체 칩_2', '입고', 'ORD003', 'EMP002', 'WH001', TO_DATE('2024-08-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV003, ORD003, PROD002

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_스마트폰_17', '출고', 'ORD004', 'EMP002', 'WH007', TO_DATE('2024-08-16 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV004, ORD004, PROD017

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_커넥터_3', '입고', 'ORD005', 'EMP003', 'WH002', TO_DATE('2024-09-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV005, ORD005, PROD003

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_태블릿_18', '출고', 'ORD006', 'EMP003', 'WH001', TO_DATE('2024-09-02 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV006, ORD006, PROD018

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_저항기_4', '입고', 'ORD007', 'EMP004', 'WH002', TO_DATE('2024-09-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV007, ORD007, PROD004

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_헤드셋_19', '출고', 'ORD008', 'EMP004', 'WH001', TO_DATE('2024-09-16 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV008, ORD008, PROD019

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_콘덴서_5', '입고', 'ORD009', 'EMP005', 'WH003', TO_DATE('2024-09-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV009, ORD009, PROD005

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_모니터_20', '출고', 'ORD010', 'EMP005', 'WH002', TO_DATE('2024-10-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV010, ORD010, PROD020

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_다이오드_6', '입고', 'ORD011', 'EMP006', 'WH003', TO_DATE('2024-10-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV011, ORD011, PROD006

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_트랜지스터_7', '입고', 'ORD012', 'EMP007', 'WH004', TO_DATE('2024-10-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV012, ORD012, PROD007

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_키보드_21', '출고', 'ORD013', 'EMP006', 'WH002', TO_DATE('2024-10-11 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV013, ORD013, PROD021

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_LED_8', '입고', 'ORD015', 'EMP008', 'WH004', TO_DATE('2024-10-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV015, ORD015, PROD008

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_마우스_22', '출고', 'ORD016', 'EMP007', 'WH003', TO_DATE('2024-10-21 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV016, ORD016, PROD022

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_외장하드_23', '출고', 'ORD017', 'EMP008', 'WH003', TO_DATE('2024-10-25 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV017, ORD017, PROD023

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_USB드라이브_24', '출고', 'ORD018', 'EMP009', 'WH004', TO_DATE('2024-10-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV018, ORD018, PROD024

INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_센서_9', '입고', 'ORD019', 'EMP009', 'WH005', TO_DATE('2024-10-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV019, ORD019, PROD009

--INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
--VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_릴레이_20241101', '입고', 'ORD020', 'EMP010', 'WH005', TO_DATE('2024-11-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV020, ORD020, PROD010
--
--INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
--VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_웹캠_20241101', '출고', 'ORD021', 'EMP010', 'WH011', TO_DATE('2024-11-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV021, ORD021, PROD025
--
--INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
--VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_마이크로컨트롤러_20241110', '입고', 'ORD022', 'EMP011', 'WH006', TO_DATE('2024-11-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV022, ORD022, PROD011
--
--INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
--VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_배터리 셀_20241120', '입고', 'ORD024', 'EMP012', 'WH006', TO_DATE('2024-12-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV023, ORD024, PROD012
--
--INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
--VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_TV_20241110', '출고', 'ORD023', 'EMP011', 'WH012', TO_DATE('2024-12-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV024, ORD023, PROD026
--
--INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
--VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_냉장고_20241120', '출고', 'ORD025', 'EMP012', 'WH012', TO_DATE('2024-12-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV025, ORD025, PROD027
--
--INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
--VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_LCD 패널_20241201', '입고', 'ORD026', 'EMP013', 'WH001', TO_DATE('2025-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV026, ORD026, PROD013
--
--INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
--VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_에어컨_20241201', '출고', 'ORD027', 'EMP013', 'WH007', TO_DATE('2025-01-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV027, ORD027, PROD028
--
--INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
--VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '입고_케이블_20241210', '입고', 'ORD028', 'EMP014', 'WH002', TO_DATE('2025-02-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV028, ORD028, PROD014
--
--INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
--VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_세탁기_20241210', '출고', 'ORD029', 'EMP014', 'WH008', TO_DATE('2025-03-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV029, ORD029, PROD029
--
--INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
--VALUES ('INV' || LPAD(seq_inoutvoice.NEXTVAL, 3, '0'), '출고_청소기_20241220', '출고', 'ORD030', 'EMP015', 'WH009', TO_DATE('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- INV030, ORD030, PROD030

-- 트리거 재활성화
--ALTER TRIGGER trg_inoutvoice ENABLE;


-- 7. TB_STOCK_HISTORY
-- TB_STOCK_HISTORY 샘플 데이터 30개 삽입 (입고 15개, 출고 15개)
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH001', 'PROD001', 500, 150, '입고', TO_DATE('2024-08-01', 'YYYY-MM-DD'), 'EMP001', 'INV001'); -- INV001, ORD001, PROD001

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH007', 'PROD016', 30, 10, '출고', TO_DATE('2024-08-02', 'YYYY-MM-DD'), 'EMP001', 'INV002'); -- INV002, ORD002, PROD016

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH001', 'PROD002', 600, 180, '입고', TO_DATE('2024-08-15', 'YYYY-MM-DD'), 'EMP002', 'INV003'); -- INV003, ORD003, PROD002

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH007', 'PROD017', 45, 15, '출고', TO_DATE('2024-08-16', 'YYYY-MM-DD'), 'EMP002', 'INV004'); -- INV004, ORD004, PROD017

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH002', 'PROD003', 800, 200, '입고', TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'EMP003', 'INV005'); -- INV005, ORD005, PROD003

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH001', 'PROD018', 60, 20, '출고', TO_DATE('2024-09-02', 'YYYY-MM-DD'), 'EMP003', 'INV006'); -- INV006, ORD006, PROD018

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH002', 'PROD004', 2000, 500, '입고', TO_DATE('2024-09-15', 'YYYY-MM-DD'), 'EMP004', 'INV007'); -- INV007, ORD007, PROD004

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH001', 'PROD019', 90, 30, '출고', TO_DATE('2024-09-16', 'YYYY-MM-DD'), 'EMP004', 'INV008'); -- INV008, ORD008, PROD019

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH003', 'PROD005', 1200, 300, '입고', TO_DATE('2024-09-30', 'YYYY-MM-DD'), 'EMP005', 'INV009'); -- INV009, ORD009, PROD005

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH002', 'PROD020', 45, 15, '출고', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 'EMP005', 'INV010'); -- INV010, ORD010, PROD020

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH003', 'PROD006', 1600, 400, '입고', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 'EMP006', 'INV011'); -- INV011, ORD011, PROD006

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH004', 'PROD007', 1000, 250, '입고', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'EMP007', 'INV012'); -- INV012, ORD012, PROD007

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH002', 'PROD021', 75, 25, '출고', TO_DATE('2024-10-11', 'YYYY-MM-DD'), 'EMP006', 'INV013'); -- INV013, ORD013, PROD021

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH003', 'PROD015', 360, 90, '입고', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 'EMP015', 'INV014'); -- INV014, ORD014, PROD015

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH004', 'PROD008', 2400, 600, '입고', TO_DATE('2024-10-20', 'YYYY-MM-DD'), 'EMP008', 'INV015'); -- INV015, ORD015, PROD008

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH003', 'PROD022', 60, 20, '출고', TO_DATE('2024-10-21', 'YYYY-MM-DD'), 'EMP007', 'INV016'); -- INV016, ORD016, PROD022

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH003', 'PROD023', 30, 10, '출고', TO_DATE('2024-10-25', 'YYYY-MM-DD'), 'EMP008', 'INV017'); -- INV017, ORD017, PROD023

INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH004', 'PROD024', 150, 50, '출고', TO_DATE('2024-10-30', 'YYYY-MM-DD'), 'EMP009', 'INV018'); -- INV018, ORD018, PROD024

--INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
--VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH005', 'PROD009', 600, 150, '입고', TO_DATE('2024-10-30', 'YYYY-MM-DD'), 'EMP009', 'INV019'); -- INV019, ORD019, PROD009
--
--INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
--VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH005', 'PROD010', 800, 200, '입고', TO_DATE('2024-11-01', 'YYYY-MM-DD'), 'EMP010', 'INV020'); -- INV020, ORD020, PROD010
--
--INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
--VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH011', 'PROD025', 45, 15, '출고', TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'EMP010', 'INV021'); -- INV021, ORD021, PROD025
--
--INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
--VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH006', 'PROD011', 400, 100, '입고', TO_DATE('2024-11-15', 'YYYY-MM-DD'), 'EMP011', 'INV022'); -- INV022, ORD022, PROD011
--
--INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
--VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH006', 'PROD012', 480, 120, '입고', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'EMP012', 'INV023'); -- INV023, ORD024, PROD012
--
--INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
--VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH012', 'PROD026', 30, 10, '출고', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'EMP011', 'INV024'); -- INV024, ORD023, PROD026
--
--INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
--VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH012', 'PROD027', 24, 8, '출고', TO_DATE('2024-12-15', 'YYYY-MM-DD'), 'EMP012', 'INV025'); -- INV025, ORD025, PROD027
--
--INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
--VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH001', 'PROD013', 320, 80, '입고', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'EMP013', 'INV026'); -- INV026, ORD026, PROD013
--
--INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
--VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH007', 'PROD028', 36, 12, '출고', TO_DATE('2025-01-15', 'YYYY-MM-DD'), 'EMP013', 'INV027'); -- INV027, ORD027, PROD028
--
--INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
--VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH002', 'PROD014', 600, 150, '입고', TO_DATE('2025-02-01', 'YYYY-MM-DD'), 'EMP014', 'INV028'); -- INV028, ORD028, PROD014
--
--INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
--VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH008', 'PROD029', 45, 15, '출고', TO_DATE('2025-03-01', 'YYYY-MM-DD'), 'EMP014', 'INV029'); -- INV029, ORD029, PROD029
--
--INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, change_date, created_by, Inoutvoice_id)
--VALUES ('SH' || LPAD(seq_stock_history.NEXTVAL, 3, '0'), 'WH009', 'PROD030', 60, 20, '출고', TO_DATE('2025-04-01', 'YYYY-MM-DD'), 'EMP015', 'INV030'); -- INV030, ORD030, PROD030


-- TB_STOCK_HISTORY의 Inoutvoice_id 업데이트 (SH001~SH030)
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV001' WHERE stock_history_id = 'SH001';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV002' WHERE stock_history_id = 'SH002';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV003' WHERE stock_history_id = 'SH003';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV004' WHERE stock_history_id = 'SH004';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV005' WHERE stock_history_id = 'SH005';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV006' WHERE stock_history_id = 'SH006';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV007' WHERE stock_history_id = 'SH007';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV008' WHERE stock_history_id = 'SH008';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV009' WHERE stock_history_id = 'SH009';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV010' WHERE stock_history_id = 'SH010';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV011' WHERE stock_history_id = 'SH011';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV012' WHERE stock_history_id = 'SH012';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV013' WHERE stock_history_id = 'SH013';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV014' WHERE stock_history_id = 'SH014';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV015' WHERE stock_history_id = 'SH015';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV016' WHERE stock_history_id = 'SH016';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV017' WHERE stock_history_id = 'SH017';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV018' WHERE stock_history_id = 'SH018';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV019' WHERE stock_history_id = 'SH019';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV020' WHERE stock_history_id = 'SH020';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV021' WHERE stock_history_id = 'SH021';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV022' WHERE stock_history_id = 'SH022';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV023' WHERE stock_history_id = 'SH023';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV024' WHERE stock_history_id = 'SH024';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV025' WHERE stock_history_id = 'SH025';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV026' WHERE stock_history_id = 'SH026';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV027' WHERE stock_history_id = 'SH027';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV028' WHERE stock_history_id = 'SH028';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV029' WHERE stock_history_id = 'SH029';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV030' WHERE stock_history_id = 'SH030';



-- 10. TB_APPROVAL_DOCUMENTS (15개)
-- TB_APPROVAL_DOCUMENTS 샘플 데이터 15개 삽입
-- 주문 관련 문서 (입고요청서, 출고요청서, 계약서)
INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '회로기판 입고 승인 요청', '회로기판 100개 입고 요청에 대한 승인 문서입니다. (주문일: 2024-08-01)', 'EMP001', TO_DATE('2024-07-31', 'YYYY-MM-DD'), '승인', '입고요청서', TO_DATE('2024-08-02', 'YYYY-MM-DD'), 'EMP011', 'EMP032', 'EMP026');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '노트북 출고 승인 요청', '노트북 50개 출고 요청에 대한 승인 문서입니다. (주문일: 2024-08-02)', 'EMP004', TO_DATE('2024-08-01', 'YYYY-MM-DD'), '승인', '출고요청서', TO_DATE('2024-08-03', 'YYYY-MM-DD'), 'EMP014', 'EMP009', 'EMP027');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '커넥터 입고 승인 요청', '커넥터 200개 입고 요청에 대한 승인 문서입니다. (주문일: 2024-09-01)', 'EMP006', TO_DATE('2024-08-31', 'YYYY-MM-DD'), '승인', '입고요청서', TO_DATE('2024-09-02', 'YYYY-MM-DD'), 'EMP017', 'EMP033', 'EMP027');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '태블릿 출고 승인 요청', '태블릿 30개 출고 요청에 대한 승인 문서입니다. (주문일: 2024-09-02)', 'EMP007', TO_DATE('2024-09-01', 'YYYY-MM-DD'), '승인', '출고요청서', TO_DATE('2024-09-03', 'YYYY-MM-DD'), 'EMP002', 'EMP024', 'EMP027');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '콘덴서 입고 승인 요청', '콘덴서 150개 입고 요청에 대한 승인 문서입니다. (주문일: 2024-09-30)', 'EMP007', TO_DATE('2024-09-29', 'YYYY-MM-DD'), '반려', '입고요청서', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 'EMP017', 'EMP033', 'EMP027');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '모니터 출고 승인 요청', '모니터 40개 출고 요청에 대한 승인 문서입니다. (주문일: 2024-10-01)', 'EMP007', TO_DATE('2025-04-01', 'YYYY-MM-DD'), '발송', '출고요청서', NULL, 'EMP002', 'EMP003', 'EMP028');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '트랜지스터 공급 계약서', '트랜지스터 공급 계약 체결 요청: 계약 금액 5,000,000원, 기간 2024-10-10 ~ 2024-12-31.', 'EMP006', TO_DATE('2024-10-09', 'YYYY-MM-DD'), '승인', '계약서', TO_DATE('2024-10-11', 'YYYY-MM-DD'), 'EMP011', 'EMP032', 'EMP026');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '센서 공급 계약서', '센서 공급 계약 체결 요청: 계약 금액 8,000,000원, 기간 2024-10-30 ~ 2024-12-31.', 'EMP021', TO_DATE('2024-10-29', 'YYYY-MM-DD'), '승인', '계약서', TO_DATE('2024-10-31', 'YYYY-MM-DD'), 'EMP011', 'EMP032', 'EMP026');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '마이크로컨트롤러 공급 계약서', '마이크로컨트롤러 공급 계약 체결 요청: 계약 금액 6,000,000원, 기간 2024-11-15 ~ 2024-12-31.', 'EMP022', TO_DATE('2025-04-02', 'YYYY-MM-DD'), '발송', '계약서', NULL, 'EMP002', 'EMP024', 'EMP027');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '사무용품 구매 품의서', '사무실 프린터 및 잉크 구매 요청: 예상 비용 1,200,000원.', 'EMP013', TO_DATE('2024-12-21', 'YYYY-MM-DD'), '승인', '품의서', TO_DATE('2024-12-22', 'YYYY-MM-DD'), 'EMP008', 'EMP003', 'EMP028');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '신규 마케팅 캠페인 기안서', '2025년 하반기 디지털 마케팅 캠페인 실행 제안: 예상 비용 3,000,000원.', 'EMP019', TO_DATE('2024-12-22', 'YYYY-MM-DD'), '반려', '기안서', TO_DATE('2024-12-23', 'YYYY-MM-DD'), 'EMP014', 'EMP009', 'EMP029');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '5월 영업 실적 보고서', '2024년 12월 영업부 실적: 매출 50,000,000원, 주요 고객 계약 3건.', 'EMP021', TO_DATE('2024-12-23', 'YYYY-MM-DD'), '승인', '보고서', TO_DATE('2024-12-24', 'YYYY-MM-DD'), 'EMP011', 'EMP032', 'EMP026');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '신규 서버 도입 품의서', '데이터 센터 서버 업그레이드 요청: 예상 비용 10,000,000원.', 'EMP025', TO_DATE('2024-12-24', 'YYYY-MM-DD'), '승인', '품의서', TO_DATE('2024-12-25', 'YYYY-MM-DD'), 'EMP005', 'EMP015', 'EMP030');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '재고 관리 프로세스 개선 기안서', '재고 관리 자동화 시스템 도입 제안: 예상 비용 2,500,000원.', 'EMP010', TO_DATE('2025-04-03', 'YYYY-MM-DD'), '발송', '기안서', NULL, 'EMP020', 'EMP015', 'EMP030');

INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, approval_date, referencer_id, reviewer_id, approver_id)
VALUES ('DOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_approval_documents.NEXTVAL, 3, '0'), '4분기 재고 감사 보고서', '2024년 4분기 재고 감사 결과: 불량 재고 5%, 개선 필요.', 'EMP018', TO_DATE('2024-12-26', 'YYYY-MM-DD'), '승인', '보고서', TO_DATE('2024-12-27', 'YYYY-MM-DD'), 'EMP023', 'EMP003', 'EMP028');


-- 11. TB_TRANSACTION_DOCUMENTS (15개)
-- TB_TRANSACTION_DOCUMENTS 샘플 데이터 삽입 (18개)
INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    '노트북 출고계약서_16', '출고계약서', '판매처', 'PART006', TO_DATE('2024-07-10', 'YYYY-MM-DD'), 'EMP003', TO_DATE('2025-04-30', 'YYYY-MM-DD'), '유효',
    '노트북 출고계약서_16: PART006 판매처와의 노트북 출고 계약. 계약 내용은 2024년 7월 10일부터 유효하며, 상세 품목 및 조건은 첨부 문서 참조.'
);

INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    '노트북 납품확인서_16', '납품확인서', '판매처', 'PART006', TO_DATE('2024-07-20', 'YYYY-MM-DD'), 'EMP003', TO_DATE('2025-03-31', 'YYYY-MM-DD'), '유효',
    '노트북 납품확인서_16: PART006 판매처로의 노트북 납품 완료. 납품 일자 2024년 7월 20일, 상세 내역은 첨부 문서 확인.'
);

INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    '회로기판 납품확인서_1', '납품확인서', '공급처', 'PART001', TO_DATE('2024-07-22', 'YYYY-MM-DD'), 'EMP002', TO_DATE('2025-04-15', 'YYYY-MM-DD'), '유효',
    '회로기판 납품확인서_1: PART001 공급처로부터 회로기판 납품 완료. 납품 일자 2024년 7월 22일, 품질 확인 완료.'
);

INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    '태블릿 출고계약서_18', '출고계약서', '판매처', 'PART008', TO_DATE('2024-08-05', 'YYYY-MM-DD'), 'EMP005', TO_DATE('2025-09-01', 'YYYY-MM-DD'), '유효',
    '태블릿 출고계약서_18: PART008 판매처와의 태블릿 출고 계약. 계약 유효 기간은 2024년 8월 5일부터 2025년 9월 1일까지.'
);

INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    '태블릿 납품확인서_18', '납품확인서', '판매처', 'PART008', TO_DATE('2024-08-06', 'YYYY-MM-DD'), 'EMP005', TO_DATE('2025-09-03', 'YYYY-MM-DD'), '유효',
    '태블릿 납품확인서_18: PART008 판매처로 태블릿 납품 완료. 납품 일자 2024년 8월 6일, 상세 내역은 첨부 문서 참조.'
);

INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    '커넥터 납품확인서_3', '납품확인서', '공급처', 'PART003', TO_DATE('2024-08-14', 'YYYY-MM-DD'), 'EMP004', TO_DATE('2025-09-02', 'YYYY-MM-DD'), '유효',
    '커넥터 납품확인서_3: PART003 공급처로부터 커넥터 납품 완료. 납품 일자 2024년 8월 14일, 품질 검사 통과.'
);

INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    '모니터 출고계약서_20', '출고계약서', '판매처', 'PART010', TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'EMP007', TO_DATE('2025-09-30', 'YYYY-MM-DD'), '유효',
    '모니터 출고계약서_20: PART010 판매처와의 모니터 출고 계약. 계약은 2024년 9월 1일부터 유효하며, 세부 조건은 첨부 문서 확인.'
);

INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    '마우스 출고계약서_22', '출고계약서', '판매처', 'PART007', TO_DATE('2024-09-20', 'YYYY-MM-DD'), 'EMP009', TO_DATE('2025-10-20', 'YYYY-MM-DD'), '유효',
    '마우스 출고계약서_22: PART007 판매처와의 마우스 출고 계약. 계약 유효 기간은 2024년 9월 20일부터 2025년 10월 20일까지.'
);

INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    '센서 입고계약서_9', '입고계약서', '공급처', 'PART004', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 'EMP013', TO_DATE('2025-10-29', 'YYYY-MM-DD'), '유효',
    '센서 입고계약서_9: PART004 공급처로부터 센서 입고 계약. 계약은 2024년 10월 1일부터 유효하며, 상세 품목은 첨부 문서 참조.'
);

INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    'USB드라이브 출고계약서_24', '출고계약서', '판매처', 'PART009', TO_DATE('2024-11-15', 'YYYY-MM-DD'), 'EMP011', TO_DATE('2025-10-29', 'YYYY-MM-DD'), '유효',
    'USB드라이브 출고계약서_24: PART009 판매처와의 USB드라이브 출고 계약. 계약은 2024년 11월 15일부터 유효.'
);

INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    '사무용품 영수증', '영수증', '공급처', 'PART001', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'EMP007', TO_DATE('2025-12-22', 'YYYY-MM-DD'), '유효',
    '사무용품 영수증: PART001 공급처로부터 사무용품 구매. 구매 일자 2024년 12월 1일, 상세 내역은 첨부 영수증 확인.'
);

INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    '마케팅 캠페인 영수증', '영수증', '판매처', 'PART002', TO_DATE('2024-12-02', 'YYYY-MM-DD'), 'EMP009', TO_DATE('2025-12-23', 'YYYY-MM-DD'), '유효',
    '마케팅 캠페인 영수증: PART002 판매처와의 마케팅 캠페인 비용 정산. 결제 일자 2024년 12월 2일.'
);

INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    '서버 구매 영수증', '영수증', '공급처', 'PART003', TO_DATE('2024-12-03', 'YYYY-MM-DD'), 'EMP012', TO_DATE('2025-12-25', 'YYYY-MM-DD'), '유효',
    '서버 구매 영수증: PART003 공급처로부터 서버 구매. 구매 일자 2024년 12월 3일, 상세 사양은 첨부 문서 참조.'
);

INSERT INTO TB_TRANSACTION_DOCUMENTS (
    tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until, status, content)
VALUES (
    'TDOC-' || TO_CHAR(SYSDATE, 'YY') || '-' || LPAD(seq_transaction_documents.NEXTVAL, 3, '0'),
    '재고 관리 시스템 영수증', '영수증', '공급처', 'PART004', TO_DATE('2024-12-04', 'YYYY-MM-DD'), 'EMP014', TO_DATE('2025-12-26', 'YYYY-MM-DD'), '유효',
    '재고 관리 시스템 영수증: PART004 공급처로부터 재고 관리 시스템 구매. 구매 일자 2024년 12월 4일.'
);


-- 12. TB_ROLE_GROUP (8개)
INSERT INTO TB_ROLE_GROUP (role_group_id, role_group_name, created_at)
VALUES ('RG001', '슈퍼관리자', SYSDATE);
INSERT INTO TB_ROLE_GROUP (role_group_id, role_group_name, created_at)
VALUES ('RG002', '재고관리자', SYSDATE);
INSERT INTO TB_ROLE_GROUP (role_group_id, role_group_name, created_at)
VALUES ('RG003', '거래처관리자', SYSDATE);
INSERT INTO TB_ROLE_GROUP (role_group_id, role_group_name, created_at)
VALUES ('RG004', '일반사용자', SYSDATE);
INSERT INTO TB_ROLE_GROUP (role_group_id, role_group_name, created_at)
VALUES ('RG005', '결재자', SYSDATE);


-- 13. TB_USER_ROLE (10개)
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP001', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP002', 'RG002');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP003', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP004', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP005', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP006', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP007', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP008', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP009', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP010', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP011', 'RG003');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP012', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP013', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP014', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP015', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP016', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP017', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP018', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP019', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP020', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP021', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP022', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP023', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP024', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP025', 'RG004');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP026', 'RG005');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP027', 'RG005');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP028', 'RG005');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP029', 'RG005');
INSERT INTO TB_USER_ROLE (user_id, role_group_id)
VALUES ('EMP030', 'RG001');




-- 14. TB_PERMISSION_CODE (17개)
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM001', '매출 정보 조회', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM002', '계정 관리', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM003', '거래처 등록/수정', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM004', '거래처 삭제', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM005', '창고 등록/수정', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM006', '창고 삭제', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM007', '공지사항 관리', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM008', '긴급 공지사항 설정', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM009', '상품 등록/수정', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM010', '상품 삭제', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM011', '재고 조정', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM012', '입출고 전표 등록/수정', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM013', '입출고 전표 삭제', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM014', '결재문서 작성/수정/회수', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM015', '결재문서 처리', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM016', '비상연락망 수정', 'Y');
INSERT INTO TB_PERMISSION_CODE (permission_code, permission_name, is_active)
VALUES ('PERM017', '사용자 정보 수정', 'Y');




-- 15. TB_ROLE_PERMISSION (10개)
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM001');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM002');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM003');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM004');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM005');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM006');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM007');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM008');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM009');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM010');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM011');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM012');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM013');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM014');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM015');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM016');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG001', 'PERM017');


INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG002', 'PERM001');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG002', 'PERM005');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG002', 'PERM006');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG002', 'PERM007');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG002', 'PERM009');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG002', 'PERM010');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG002', 'PERM011');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG002', 'PERM012');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG002', 'PERM013');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG002', 'PERM014');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG002', 'PERM017');


INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG003', 'PERM001');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG003', 'PERM003');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG003', 'PERM004');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG003', 'PERM007');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG003', 'PERM014');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG003', 'PERM017');


INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG004', 'PERM014');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG004', 'PERM017');


INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG005', 'PERM001');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG005', 'PERM007');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG005', 'PERM014');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG005', 'PERM015');
INSERT INTO TB_ROLE_PERMISSION (role_group_id, permission_code)
VALUES ('RG005', 'PERM017');


-- 16. TB_NOTICE_BOARD (8개)
INSERT INTO TB_NOTICE_BOARD (post_id, title, content, author, created_at, view_count)
VALUES (seq_notice_board.NEXTVAL, '시스템 점검 공지', '5월 20일 시스템 점검 예정입니다.', 'EMP030', TO_DATE('2024-01-10', 'YYYY-MM-DD'), 10);
INSERT INTO TB_NOTICE_BOARD (post_id, title, content, author, created_at, view_count)
VALUES (seq_notice_board.NEXTVAL, '신규 상품 등록 안내', '신규 전자제품 등록이 완료되었습니다.', 'EMP001', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 5);
INSERT INTO TB_NOTICE_BOARD (post_id, title, content, author, created_at, view_count)
VALUES (seq_notice_board.NEXTVAL, '창고 점검 공지', '5월 25일 모든 창고 점검이 진행됩니다.', 'EMP004', TO_DATE('2024-05-20', 'YYYY-MM-DD'), 8);
INSERT INTO TB_NOTICE_BOARD (post_id, title, content, author, created_at, view_count)
VALUES (seq_notice_board.NEXTVAL, '주문 처리 지연 안내', '일부 주문 처리 지연 안내드립니다.', 'EMP005', TO_DATE('2024-07-25', 'YYYY-MM-DD'), 15);
INSERT INTO TB_NOTICE_BOARD (post_id, title, content, author, created_at, view_count)
VALUES (seq_notice_board.NEXTVAL, '신규 파트너 등록 안내', '신규 파트너사 등록이 완료되었습니다.', 'EMP006', TO_DATE('2024-09-30', 'YYYY-MM-DD'), 7);
INSERT INTO TB_NOTICE_BOARD (post_id, title, content, author, created_at, view_count)
VALUES (seq_notice_board.NEXTVAL, '물류 시스템 업데이트', '물류 시스템 업데이트 안내드립니다.', 'EMP007', TO_DATE('2024-12-05', 'YYYY-MM-DD'), 12);
INSERT INTO TB_NOTICE_BOARD (post_id, title, content, author, created_at, view_count)
VALUES (seq_notice_board.NEXTVAL, '사용자 교육 세션', '신규 사용자 교육 세션 안내드립니다.', 'EMP008', TO_DATE('2025-02-10', 'YYYY-MM-DD'), 9);
INSERT INTO TB_NOTICE_BOARD (post_id, title, content, author, created_at, view_count)
VALUES (seq_notice_board.NEXTVAL, '연말 결산 공지', '연말 결산 일정 안내드립니다.', 'EMP009', TO_DATE('2025-04-15', 'YYYY-MM-DD'), 6);
-- 커밋
COMMIT;





---- 경유창고(WH013)용 상품 샘플 데이터
--INSERT INTO TB_PRODUCT (product_id, product_name, option_value, product_type, cost_price, selling_price, category, safe_stock)
--VALUES ('P013001', '경유 필터', '대형', '부품', 15000, 25000, '엔진부품', 50);
--
--INSERT INTO TB_PRODUCT (product_id, product_name, option_value, product_type, cost_price, selling_price, category, safe_stock)
--VALUES ('P013002', '경유 펌프', '고압', '부품', 35000, 55000, '엔진부품', 30);
--
--INSERT INTO TB_PRODUCT (product_id, product_name, option_value, product_type, cost_price, selling_price, category, safe_stock)
--VALUES ('P013003', '경유 탱크', '100L', '부품', 120000, 180000, '연료시스템', 20);
--
---- 불량창고(WH014)용 상품 샘플 데이터
--INSERT INTO TB_PRODUCT (product_id, product_name, option_value, product_type, cost_price, selling_price, category, safe_stock)
--VALUES ('P014001', '불량 엔진 블록', 'V6', '부품', 50000, 0, '엔진부품', 0);
--
--INSERT INTO TB_PRODUCT (product_id, product_name, option_value, product_type, cost_price, selling_price, category, safe_stock)
--VALUES ('P014002', '불량 터보차저', '2.0L', '부품', 30000, 0, '엔진부품', 0);
--
--INSERT INTO TB_PRODUCT (product_id, product_name, option_value, product_type, cost_price, selling_price, category, safe_stock)
--VALUES ('P014003', '불량 배터리', '12V', '부품', 20000, 0, '전기부품', 0);
--
---- 경유창고(WH013) 재고 데이터
--INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
--VALUES ('WH013', 'P013001', 100);
--
--INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
--VALUES ('WH013', 'P013002', 50);
--
--INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
--VALUES ('WH013', 'P013003', 30);
--
---- 불량창고(WH014) 재고 데이터
--INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
--VALUES ('WH014', 'P014001', 0);
--
--INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
--VALUES ('WH014', 'P014002', 0);
--
--INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, stock)
--VALUES ('WH014', 'P014003', 0);





-- TB_TRANSACTION_DOCUMENTS 테이블의 uploaded_at 값 수정
UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-10-01', 'YYYY-MM-DD') 
WHERE doc_name = '센서 입고계약서_9';

UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-07-10', 'YYYY-MM-DD') 
WHERE doc_name = '노트북 출고계약서_16';

UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-08-05', 'YYYY-MM-DD') 
WHERE doc_name = '태블릿 출고계약서_18';

UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-09-01', 'YYYY-MM-DD') 
WHERE doc_name = '모니터 출고계약서_20';

UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-09-20', 'YYYY-MM-DD') 
WHERE doc_name = '마우스 출고계약서_22';

UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-10-01', 'YYYY-MM-DD') 
WHERE doc_name = 'USB드라이브 출고계약서_24';

UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-07-22', 'YYYY-MM-DD') 
WHERE doc_name = '회로기판 납품확인서_1';

UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-08-14', 'YYYY-MM-DD') 
WHERE doc_name = '커넥터 납품확인서_3';

UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-07-20', 'YYYY-MM-DD') 
WHERE doc_name = '노트북 납품확인서_16';

UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-08-06', 'YYYY-MM-DD') 
WHERE doc_name = '태블릿 납품확인서_18';

UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-12-01', 'YYYY-MM-DD') 
WHERE doc_name = '사무용품 영수증';

UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-12-02', 'YYYY-MM-DD') 
WHERE doc_name = '마케팅 캠페인 영수증';

UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-12-03', 'YYYY-MM-DD') 
WHERE doc_name = '서버 구매 영수증';

UPDATE TB_TRANSACTION_DOCUMENTS 
SET uploaded_at = TO_DATE('2024-12-04', 'YYYY-MM-DD') 
WHERE doc_name = '재고 관리 시스템 영수증';

