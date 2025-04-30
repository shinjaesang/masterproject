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

-- 시퀀스 드롭
DROP SEQUENCE seq_orders;
DROP SEQUENCE seq_order_status_history;
DROP SEQUENCE seq_transaction_documents;
DROP SEQUENCE seq_notice_board;

-- 시퀀스 생성
CREATE SEQUENCE seq_orders START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_order_status_history START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_transaction_documents START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_notice_board START WITH 1 INCREMENT BY 1;

-- 1. TB_USER
CREATE TABLE TB_USER (
    empid VARCHAR2(20) PRIMARY KEY,
    empname VARCHAR2(50) NOT NULL,
    department VARCHAR2(50),
    job VARCHAR2(50),
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
    CONSTRAINT fk_partner_empid FOREIGN KEY (empid) REFERENCES TB_USER(empid)
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
    CONSTRAINT fk_warehouse_empid FOREIGN KEY (empid) REFERENCES TB_USER(empid)
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
    partner_id VARCHAR2(20) NOT NULL,
    product_name VARCHAR2(255) NOT NULL,
    option_value VARCHAR2(100),
    cost_price NUMBER(10,2) NOT NULL,
    selling_price NUMBER(10,2) NOT NULL,
    manufacturer VARCHAR2(100),
    country_of_origin VARCHAR2(100),
    category VARCHAR2(100),
    safe_stock NUMBER DEFAULT 0,
    product_image BLOB,
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE,
    CONSTRAINT fk_product_partner_id FOREIGN KEY (partner_id) REFERENCES TB_PARTNER(partner_id)
);

COMMENT ON COLUMN TB_PRODUCT.product_id IS '상품 ID'; 
COMMENT ON COLUMN TB_PRODUCT.partner_id IS '거래처 ID'; 
COMMENT ON COLUMN TB_PRODUCT.product_name IS '상품 이름'; 
COMMENT ON COLUMN TB_PRODUCT.option_value IS '상품 옵션'; 
COMMENT ON COLUMN TB_PRODUCT.cost_price IS '원가'; 
COMMENT ON COLUMN TB_PRODUCT.selling_price IS '판매가'; 
COMMENT ON COLUMN TB_PRODUCT.manufacturer IS '제조사'; 
COMMENT ON COLUMN TB_PRODUCT.country_of_origin IS '원산지'; 
COMMENT ON COLUMN TB_PRODUCT.category IS '카테고리'; 
COMMENT ON COLUMN TB_PRODUCT.safe_stock IS '안전 재고 수량'; 
COMMENT ON COLUMN TB_PRODUCT.product_image IS '제품 이미지'; 
COMMENT ON COLUMN TB_PRODUCT.created_at IS '등록일'; 
COMMENT ON COLUMN TB_PRODUCT.updated_at IS '수정일';



-- 5. TB_WAREHOUSE_STOCK
CREATE TABLE TB_WAREHOUSE_STOCK (
    warehouse_id VARCHAR2(20),
    product_id VARCHAR2(50),
    normal_stock NUMBER DEFAULT 0,
    defective_stock NUMBER DEFAULT 0,
    CONSTRAINT pk_warehouse_stock PRIMARY KEY (warehouse_id, product_id),
    CONSTRAINT fk_wstock_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES TB_WAREHOUSE(warehouse_id),
    CONSTRAINT fk_wstock_product_id FOREIGN KEY (product_id) REFERENCES TB_PRODUCT(product_id)
);

COMMENT ON COLUMN TB_WAREHOUSE_STOCK.warehouse_id IS '창고 ID'; 
COMMENT ON COLUMN TB_WAREHOUSE_STOCK.product_id IS '제품 ID'; 
COMMENT ON COLUMN TB_WAREHOUSE_STOCK.normal_stock IS '정상 재고 수량'; 
COMMENT ON COLUMN TB_WAREHOUSE_STOCK.defective_stock IS '불량 재고 수량';


-- 6. TB_ORDERS
CREATE TABLE TB_ORDERS (
    order_id NUMBER PRIMARY KEY,
    partner_id VARCHAR2(20) NOT NULL,
    product_id VARCHAR2(50) NOT NULL,
    quantity NUMBER NOT NULL,
    stock_status VARCHAR2(20) NOT NULL CHECK (stock_status IN ('입고', '출고')),
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_orders_partner_id FOREIGN KEY (partner_id) REFERENCES TB_PARTNER(partner_id),
    CONSTRAINT fk_orders_product_id FOREIGN KEY (product_id) REFERENCES TB_PRODUCT(product_id)
);

COMMENT ON COLUMN TB_ORDERS.order_id IS '주문 ID'; 
COMMENT ON COLUMN TB_ORDERS.partner_id IS '거래처 ID'; 
COMMENT ON COLUMN TB_ORDERS.product_id IS '상품 ID'; 
COMMENT ON COLUMN TB_ORDERS.quantity IS '주문 수량'; 
COMMENT ON COLUMN TB_ORDERS.stock_status IS '재고 상태'; 
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
    CONSTRAINT fk_stockhist_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES TB_WAREHOUSE(warehouse_id),
    CONSTRAINT fk_stockhist_product_id FOREIGN KEY (product_id) REFERENCES TB_PRODUCT(product_id),
    CONSTRAINT fk_stockhist_created_by FOREIGN KEY (created_by) REFERENCES TB_USER(empid)
);

COMMENT ON COLUMN TB_STOCK_HISTORY.stock_history_id IS '재고 이력 ID'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.warehouse_id IS '창고 ID'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.product_id IS '제품 ID'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.stock_quantity IS '현재 재고 수량'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.change_quantity IS '변경 수량';
 COMMENT ON COLUMN TB_STOCK_HISTORY.change_type IS '변경 유형'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.change_date IS '변경 날짜'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.Inoutvoice_id IS '입출고장 ID'; 
COMMENT ON COLUMN TB_STOCK_HISTORY.created_by IS '변경자 ID';


-- 8. TB_ORDER_STATUS_HISTORY
CREATE TABLE TB_ORDER_STATUS_HISTORY (
    status_history_id NUMBER PRIMARY KEY,
    order_id NUMBER NOT NULL,
    prev_stock_status VARCHAR2(20),
    stock_status VARCHAR2(20) NOT NULL CHECK (stock_status IN ('입고', '출고')),
    CONSTRAINT fk_orderstatus_order_id FOREIGN KEY (order_id) REFERENCES TB_ORDERS(order_id)
);

COMMENT ON COLUMN TB_ORDER_STATUS_HISTORY.status_history_id IS '상태 이력 ID'; COMMENT ON COLUMN TB_ORDER_STATUS_HISTORY.order_id IS '주문 ID'; 
COMMENT ON COLUMN TB_ORDER_STATUS_HISTORY.prev_stock_status IS '이전 재고 상태'; COMMENT ON COLUMN TB_ORDER_STATUS_HISTORY.stock_status IS '현재 재고 상태';



-- 9. TB_INOUTVOICE
CREATE TABLE TB_INOUTVOICE (
    Inoutvoice_id VARCHAR2(20) PRIMARY KEY,
    Inoutvoice_name VARCHAR2(100) NOT NULL,
    Inoutvoice_type VARCHAR2(10) NOT NULL CHECK (inoutvoice_type IN ('입고', '출고')),
    order_id NUMBER NOT NULL,
    worker_id VARCHAR2(20) NOT NULL,
    warehouse_id VARCHAR2(20) NOT NULL,
    created_at DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_inoutvoice_order_id FOREIGN KEY (order_id) REFERENCES TB_ORDERS(order_id),
    CONSTRAINT fk_inoutvoice_worker_id FOREIGN KEY (worker_id) REFERENCES TB_USER(empid),
    CONSTRAINT fk_inoutvoice_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES TB_WAREHOUSE(warehouse_id)
);

-- 재고 이력 테이블 외래키 추가
ALTER TABLE TB_STOCK_HISTORY
ADD CONSTRAINT fk_stockhist_Inoutvoice_id FOREIGN KEY (Inoutvoice_id) REFERENCES TB_INOUTVOICE(Inoutvoice_id);

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
    emp_id VARCHAR2(20) NOT NULL,
    draft_date DATE NOT NULL,
    approval_status VARCHAR2(20) DEFAULT '대기' CHECK (approval_status IN ('대기', '승인', '반려')),
    document_format VARCHAR2(100) NOT NULL,
    order_id NUMBER,
    approval_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_approval_emp_id FOREIGN KEY (emp_id) REFERENCES TB_USER(empid)
);

ALTER TABLE TB_APPROVAL_DOCUMENTS
ADD CONSTRAINT fk_approval_order_id FOREIGN KEY (order_id) REFERENCES TB_ORDERS(order_id);


COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.doc_id IS '문서 ID'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.title IS '문서 제목'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.content IS '문서 내용'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.attach_file IS '첨부 파일'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.emp_id IS '작성자 ID'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.draft_date IS '작성일'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.approval_status IS '결재 상태'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.document_format IS '문서 형식'; COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.order_id IS '주문 ID'; 
COMMENT ON COLUMN TB_APPROVAL_DOCUMENTS.approval_date IS '결재일'; 


-- 11. TB_TRANSACTION_DOCUMENTS
CREATE TABLE TB_TRANSACTION_DOCUMENTS (
    tdoc_id NUMBER PRIMARY KEY,
    doc_name VARCHAR2(200) NOT NULL,
    doc_type VARCHAR2(100) DEFAULT '입고계약서' NOT NULL,
    related_party_type VARCHAR2(200) DEFAULT '판매처' NOT NULL,
    related_party_id VARCHAR2(20) NOT NULL,
    uploaded_at DATE DEFAULT SYSDATE NOT NULL,
    uploaded_by VARCHAR2(20) NOT NULL,
    valid_until DATE,
    status VARCHAR2(100) DEFAULT '유효' NOT NULL,
    content CLOB,
    attached_file BLOB,
    
    CONSTRAINT ck_doc_type CHECK (doc_type IN ('입고계약서', '출고계약서', '납품확인서', '세금계산서', '영수증')),
    CONSTRAINT ck_related_party_type CHECK (related_party_type IN ('공급처', '판매처')),
    CONSTRAINT ck_status CHECK (status IN ('유효', '만료', '대기')),
    
    CONSTRAINT fk_transdoc_related_party_id FOREIGN KEY (related_party_id) REFERENCES TB_PARTNER(partner_id),
    CONSTRAINT fk_transdoc_uploaded_by FOREIGN KEY (uploaded_by) REFERENCES TB_USER(empid)
);


COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.tdoc_id IS '문서 ID'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.doc_name IS '문서 이름'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.doc_type IS '문서 유형'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.related_party_type IS '관련 거래처 유형'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.related_party_id IS '관련 거래처 ID'; COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.uploaded_at IS '업로드 날짜'; COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.uploaded_by IS '작성자 사원번호'; COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.valid_until IS '유효 기간'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.status IS '문서 상태'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.content IS '문서 내용'; 
COMMENT ON COLUMN TB_TRANSACTION_DOCUMENTS.attached_file IS '첨부 파일';


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
    CONSTRAINT fk_userrole_user_id FOREIGN KEY (user_id) REFERENCES TB_USER(empid),
    CONSTRAINT fk_userrole_role_group_id FOREIGN KEY (role_group_id) REFERENCES TB_ROLE_GROUP(role_group_id)
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
    CONSTRAINT fk_roleperm_role_group_id FOREIGN KEY (role_group_id) REFERENCES TB_ROLE_GROUP(role_group_id),
    CONSTRAINT fk_roleperm_permission_code FOREIGN KEY (permission_code) REFERENCES TB_PERMISSION_CODE(permission_code)
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
    CONSTRAINT fk_notice_author FOREIGN KEY (author) REFERENCES TB_USER(empid)
);

COMMENT ON COLUMN TB_NOTICE_BOARD.post_id IS '게시물 ID'; 
COMMENT ON COLUMN TB_NOTICE_BOARD.title IS '게시물 제목'; 
COMMENT ON COLUMN TB_NOTICE_BOARD.content IS '게시물 내용'; 
COMMENT ON COLUMN TB_NOTICE_BOARD.author IS '작성자 ID'; 
COMMENT ON COLUMN TB_NOTICE_BOARD.created_at IS '작성일'; 
COMMENT ON COLUMN TB_NOTICE_BOARD.view_count IS '조회수'; 
COMMENT ON COLUMN TB_NOTICE_BOARD.attached_file IS '첨부 파일';


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

-- TB_TRANSACTION_DOCUMENTS 
CREATE OR REPLACE TRIGGER trg_transdoc_timestamp 
BEFORE INSERT OR UPDATE ON TB_TRANSACTION_DOCUMENTS 
FOR EACH ROW BEGIN -- INSERT 시 uploaded_at과 valid_until 설정 
IF INSERTING THEN 
:NEW.uploaded_at := SYSDATE; -- valid_until은 애플리케이션에서 설정하거나, 기본값 필요 시 설정 가능 :NEW.valid_until := :NEW.valid_until; -- 또는 특정 로직 추가 -- UPDATE 시 uploaded_at 유지, valid_until 갱신 가능 
ELSIF UPDATING THEN 
:NEW.uploaded_at := :OLD.uploaded_at; -- uploaded_at은 최초 업로드 시간 유지 -- valid_until은 애플리케이션에서 갱신하거나 트리거에서 로직 추가 
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
    IF :NEW.normal_stock < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, '재고는 음수일 수 없습니다.');
    END IF;
    IF :NEW.defective_stock < 0 THEN
        RAISE_APPLICATION_ERROR(-20002, '불량 재고는 음수일 수 없습니다.');
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

-- 데이터 삽입 전 기존 테이블 초기화
DELETE FROM TB_NOTICE_BOARD;
DELETE FROM TB_ROLE_PERMISSION;
DELETE FROM TB_PERMISSION_CODE;
DELETE FROM TB_USER_ROLE;
DELETE FROM TB_ROLE_GROUP;
DELETE FROM TB_TRANSACTION_DOCUMENTS;
DELETE FROM TB_APPROVAL_DOCUMENTS;
DELETE FROM TB_INOUTVOICE;
DELETE FROM TB_ORDER_STATUS_HISTORY;
DELETE FROM TB_STOCK_HISTORY;
DELETE FROM TB_ORDERS;
DELETE FROM TB_WAREHOUSE_STOCK;
DELETE FROM TB_PRODUCT;
DELETE FROM TB_WAREHOUSE;
DELETE FROM TB_PARTNER;
DELETE FROM TB_USER;


-- 커밋
COMMIT;


-- 1. TB_USER (30개: 기존 25개 + 부서별 부장 5개)
-- 기존 데이터 유지, admin_yn 수정 및 부장 추가
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP001', '김영희', '영업부', '사원', 'yhkim@example.com', '010-1234-5678', '900101-1234567', TO_DATE('2023-01-15', 'YYYY-MM-DD'), '서울시 강남구', 'hashed_pwd1', 'N', TO_DATE('2025-04-09', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP002', '이철수', '물류부', '대리', 'cslee@example.com', '010-9876-5432', '850215-2345678', TO_DATE('2022-06-01', 'YYYY-MM-DD'), '경기도 수원시', 'hashed_pwd2', 'N', TO_DATE('2025-04-10', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP003', '박민수', '경영지원부', '과장', 'mspark@example.com', '010-5555-6666', '870324-3456789', TO_DATE('2021-03-10', 'YYYY-MM-DD'), '인천시 부평구', 'hashed_pwd3', 'N', NULL, 'Y');
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
VALUES ('EMP024', '최동혁', '인사부', '과장', 'dhchoi@example.com', '010-5555-8888', '810727-1234567', TO_DATE('2020-09-15', 'YYYY-MM-DD'), '서울시 종로구', 'hashed_pwd24', 'N', TO_DATE('2025-04-25', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP025', '정유진', '개발부', '사원', 'yjjeong@example.com', '010-9999-2222', '930808-2345678', TO_DATE('2023-11-01', 'YYYY-MM-DD'), '부산시 금정구', 'hashed_pwd25', 'N', TO_DATE('2025-04-26', 'YYYY-MM-DD'), 'Y');
-- 부서별 부장 추가 (영업부, 물류부, 경영지원부, 인사부, 개발부)
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP026', '김태형', '영업부', '부장', 'thkim@example.com', '010-1234-9999', '800101-1234567', TO_DATE('2020-01-10', 'YYYY-MM-DD'), '서울시 송파구', 'hashed_pwd26', 'N', TO_DATE('2025-04-27', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP027', '이정훈', '물류부', '부장', 'jhlee@example.com', '010-5678-0000', '790212-2345678', TO_DATE('2019-06-15', 'YYYY-MM-DD'), '경기도 부천시', 'hashed_pwd27', 'N', TO_DATE('2025-04-28', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP028', '박혜진', '경영지원부', '부장', 'hjpark@example.com', '010-9012-3333', '780323-3456789', TO_DATE('2018-03-20', 'YYYY-MM-DD'), '서울시 중구', 'hashed_pwd28', 'N', NULL, 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP029', '최민규', '인사부', '부장', 'mgchoi@example.com', '010-3456-7777', '770404-1234567', TO_DATE('2017-09-10', 'YYYY-MM-DD'), '서울시 강서구', 'hashed_pwd29', 'N', TO_DATE('2025-04-29', 'YYYY-MM-DD'), 'Y');
INSERT INTO TB_USER (empid, empname, department, job, email, phone, empno, hire_date, address, emppwd, admin_yn, last_login_date, is_active)
VALUES ('EMP030', '정혁수', '개발부', '부장', 'hsjeong@example.com', '010-7890-1111', '760515-2345678', TO_DATE('2016-12-05', 'YYYY-MM-DD'), '경기도 분당시', 'hashed_pwd30', 'Y', TO_DATE('2025-04-30', 'YYYY-MM-DD'), 'Y');


-- 2. TB_PARTNER (15개)
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART001', '공급처', 'ABC물산', 'EMP001', '김영희', '010-1234-5678', 'yhkim@example.com', '서울시 중구', '123-45-67890', '최영수', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART002', '판매처', 'XYZ상사', 'EMP002', '이철수', '010-9876-5432', 'cslee@example.com', '부산시 해운대구', '987-65-43210', '김지영', '유한회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART003', '공급처', 'DEF산업', 'EMP004', '최지훈', '010-7777-8888', 'jhchoi@example.com', '서울시 영등포구', '111-22-33344', '홍길동', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART004', '판매처', 'GHI무역', 'EMP004', '최지훈', '010-7777-8888', 'jhchoi@example.com', '인천시 남동구', '555-66-77788', '이영자', '유한회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART005', '공급처', 'JKL상사', 'EMP005', '정수진', '010-2222-3333', 'sjjeong@example.com', '대구시 달서구', '999-11-22233', '김태우', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART006', '판매처', 'MNO물류', 'EMP006', '한지민', '010-1111-2222', 'jmhan@example.com', '서울시 서초구', '444-55-66677', '박민수', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART007', '공급처', 'PQR전자', 'EMP007', '오세훈', '010-3333-4444', 'shoh@example.com', '부산시 사상구', '777-88-99900', '윤서영', '유한회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART008', '판매처', 'STU무역', 'EMP008', '윤서영', '010-5555-7777', 'syyoon@example.com', '대구시 수성구', '222-33-44455', '강태우', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART009', '공급처', 'VWX산업', 'EMP009', '강태우', '010-8888-9999', 'twkang@example.com', '서울시 강북구', '666-77-88899', '서민재', '유한회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART010', '판매처', 'YZA물산', 'EMP010', '서민재', '010-0000-1111', 'mjseo@example.com', '경기도 고양시', '111-44-55566', '김도현', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART011', '공급처', 'BCD전자', 'EMP011', '김도현', '010-2222-5555', 'dhkim@example.com', '서울시 동작구', '555-88-99911', '이수민', '유한회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART012', '판매처', 'EFG무역', 'EMP012', '이수민', '010-6666-7777', 'smlee@example.com', '인천시 서구', '999-22-33344', '박지영', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART013', '공급처', 'HIJ물류', 'EMP013', '박지영', '010-8888-0000', 'jypark@example.com', '서울시 관악구', '333-55-77788', '최윤아', '유한회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART014', '판매처', 'KLM전자', 'EMP014', '최윤아', '010-1111-3333', 'yachoi@example.com', '경기도 안양시', '777-11-22233', '정민호', '주식회사', 'Active');
INSERT INTO TB_PARTNER (partner_id, partner_type, partner_name, empid, manager_name, contact_info, email, partner_address, business_reg_no, representative_name, corporate_type, transaction_status)
VALUES ('PART015', '공급처', 'NOP산업', 'EMP015', '정민호', '010-4444-5555', 'mhjeong@example.com', '서울시 은평구', '222-66-88899', '한지우', '유한회사', 'Active');


-- 3. TB_WAREHOUSE (12개)
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH001', 'OWN', '서울창고', '서울시 송파구', 500, 'EMP002', '이철수', '010-9876-5432', 'cslee@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH002', '3PL', '부산창고', '부산시 사상구', 300, 'EMP003', '박민수', '010-5555-6666', 'mspark@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH003', 'OWN', '인천창고', '인천시 연수구', 400, 'EMP004', '최지훈', '010-7777-8888', 'jhchoi@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH004', '3PL', '대구창고', '대구시 수성구', 350, 'EMP005', '정수진', '010-2222-3333', 'sjjeong@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH005', 'OWN', '광주창고', '광주시 북구', 450, 'EMP006', '한지민', '010-1111-2222', 'jmhan@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH006', '3PL', '대전창고', '대전시 중구', 320, 'EMP007', '오세훈', '010-3333-4444', 'shoh@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH007', 'OWN', '울산창고', '울산시 남구', 380, 'EMP008', '윤서영', '010-5555-7777', 'syyoon@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH008', '3PL', '경기창고', '경기도 성남시', 400, 'EMP009', '강태우', '010-8888-9999', 'twkang@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH009', 'OWN', '강원창고', '강원도 춘천시', 300, 'EMP010', '서민재', '010-0000-1111', 'mjseo@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH010', '3PL', '충북창고', '충북 청주시', 350, 'EMP011', '김도현', '010-2222-5555', 'dhkim@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH011', 'OWN', '충남창고', '충남 천안시', 420, 'EMP012', '이수민', '010-6666-7777', 'smlee@example.com');
INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_type, warehouse_name, warehouse_address, warehouse_area, empid, manager_name, contact_info, email)
VALUES ('WH012', '3PL', '경남창고', '경남 창원시', 360, 'EMP013', '박지영', '010-8888-0000', 'jypark@example.com');


-- 4. TB_PRODUCT (30개)
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD001', 'PART001', '노트북', '16GB RAM', 800000.00, 1200000.00, '삼성전자', '한국', '전자제품', 10);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD002', 'PART002', '스마트폰', '128GB', 600000.00, 900000.00, 'LG전자', '한국', '전자제품', 15);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD003', 'PART003', '태블릿', '64GB', 400000.00, 600000.00, '삼성전자', '한국', '전자제품', 20);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD004', 'PART004', '헤드셋', '무선', 100000.00, 150000.00, 'LG전자', '한국', '전자제품', 30);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD005', 'PART005', '모니터', '27인치', 200000.00, 300000.00, '삼성전자', '한국', '전자제품', 15);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD006', 'PART006', '키보드', '기계식', 80000.00, 120000.00, '로지텍', '중국', '전자제품', 25);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD007', 'PART007', '마우스', '무선', 50000.00, 80000.00, '로지텍', '중국', '전자제품', 20);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD008', 'PART008', '외장하드', '1TB', 120000.00, 180000.00, '씨게이트', '미국', '전자제품', 10);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD009', 'PART009', 'USB드라이브', '64GB', 20000.00, 35000.00, '샌디스크', '미국', '전자제품', 50);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD010', 'PART010', '웹캠', '1080p', 70000.00, 110000.00, '로지텍', '중국', '전자제품', 15);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD011', 'PART011', '스피커', '블루투스', 90000.00, 140000.00, 'JBL', '미국', '전자제품', 20);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD012', 'PART012', '프린터', '레이저', 150000.00, 220000.00, 'HP', '미국', '전자제품', 10);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD013', 'PART013', '스캐너', '평판', 110000.00, 160000.00, '엡손', '일본', '전자제품', 15);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD014', 'PART014', '라우터', 'Wi-Fi 6', 130000.00, 190000.00, 'TP-Link', '중국', '전자제품', 20);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD015', 'PART015', '프로젝터', '4K', 500000.00, 750000.00, '엡손', '일본', '전자제품', 5);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD016', 'PART001', 'SSD', '512GB', 90000.00, 140000.00, '삼성전자', '한국', '전자제품', 25);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD017', 'PART002', '게이밍마우스', 'RGB', 60000.00, 100000.00, '레이저', '미국', '전자제품', 20);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD018', 'PART003', '모니터암', '듀얼', 70000.00, 110000.00, '에르고트론', '미국', '전자제품', 15);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD019', 'PART004', 'Professional Monitor', '4K 32인치', 300000.00, 450000.00, '삼성전자', '한국', '전자제품', 10);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD020', 'PART005', '충전기', '고속', 30000.00, 50000.00, '앤커', '중국', '전자제품', 50);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD021', 'PART006', '노트북쿨러', 'LED', 40000.00, 60000.00, '쿨러마스터', '대만', '전자제품', 30);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD022', 'PART007', '게이밍키보드', 'RGB', 100000.00, 150000.00, '레이저', '미국', '전자제품', 20);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD023', 'PART008', 'VR헤드셋', '무선', 400000.00, 600000.00, '오큘러스', '미국', '전자제품', 5);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD024', 'PART009', '스마트워치', '4G', 200000.00, 300000.00, '삼성전자', '한국', '전자제품', 15);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD025', 'PART010', '이어폰', '무선', 80000.00, 120000.00, 'JBL', '미국', '전자제품', 30);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD026', 'PART011', '게임패드', '블루투스', 60000.00, 90000.00, '엑스박스', '미국', '전자제품', 20);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD027', 'PART012', '마이크', 'USB', 70000.00, 110000.00, '블루', '미국', '전자제품', 15);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD028', 'PART013', '외장SSD', '2TB', 200000.00, 300000.00, '삼성전자', '한국', '전자제품', 10);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD029', 'PART014', '파워뱅크', '20000mAh', 40000.00, 60000.00, '샤오미', '중국', '전자제품', 40);
INSERT INTO TB_PRODUCT (product_id, partner_id, product_name, option_value, cost_price, selling_price, manufacturer, country_of_origin, category, safe_stock)
VALUES ('PROD030', 'PART015', '스마트스피커', 'AI', 100000.00, 150000.00, '아마존', '미국', '전자제품', 20);


-- 5. TB_WAREHOUSE_STOCK (30개)
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH001', 'PROD001', 50, 2);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH002', 'PROD002', 30, 1);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH003', 'PROD003', 60, 3);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH004', 'PROD004', 80, 1);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH005', 'PROD005', 40, 2);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH006', 'PROD006', 70, 0);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH007', 'PROD007', 90, 3);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH008', 'PROD008', 20, 1);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH009', 'PROD009', 100, 5);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH010', 'PROD010', 50, 2);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH011', 'PROD011', 30, 1);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH012', 'PROD012', 40, 0);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH001', 'PROD013', 60, 2);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH002', 'PROD014', 80, 3);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH003', 'PROD015', 20, 1);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH004', 'PROD016', 50, 2);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH005', 'PROD017', 70, 0);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH006', 'PROD018', 40, 1);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH007', 'PROD019', 60, 2);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH008', 'PROD020', 100, 4);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH009', 'PROD021', 80, 3);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH010', 'PROD022', 50, 1);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH011', 'PROD023', 20, 0);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH012', 'PROD024', 60, 2);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH001', 'PROD025', 90, 3);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH002', 'PROD026', 70, 1);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH003', 'PROD027', 40, 2);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH004', 'PROD028', 50, 1);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH005', 'PROD029', 80, 3);
INSERT INTO TB_WAREHOUSE_STOCK (warehouse_id, product_id, normal_stock, defective_stock)
VALUES ('WH006', 'PROD030', 60, 2);


-- 6. TB_ORDERS (30개)
-- TB_ORDERS 샘플 데이터 삽입 (30개)
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART001', 'PROD001', 20, '입고', TO_DATE('2024-01-05', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART002', 'PROD002', 15, '출고', TO_DATE('2024-01-20', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART003', 'PROD003', 10, '입고', TO_DATE('2024-02-05', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART004', 'PROD004', 25, '출고', TO_DATE('2024-02-20', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART005', 'PROD005', 30, '입고', TO_DATE('2024-03-07', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART006', 'PROD006', 20, '출고', TO_DATE('2024-03-22', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART007', 'PROD007', 40, '입고', TO_DATE('2024-04-08', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART008', 'PROD008', 15, '출고', TO_DATE('2024-04-23', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART009', 'PROD009', 50, '입고', TO_DATE('2024-05-10', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART010', 'PROD010', 20, '출고', TO_DATE('2024-05-25', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART011', 'PROD011', 25, '입고', TO_DATE('2024-06-10', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART012', 'PROD012', 10, '출고', TO_DATE('2024-06-25', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART013', 'PROD013', 30, '입고', TO_DATE('2024-07-12', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART014', 'PROD014', 20, '출고', TO_DATE('2024-07-27', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART015', 'PROD015', 5, '입고', TO_DATE('2024-08-12', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART001', 'PROD016', 25, '출고', TO_DATE('2024-08-27', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART002', 'PROD017', 20, '입고', TO_DATE('2024-09-12', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART003', 'PROD018', 15, '출고', TO_DATE('2024-09-27', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART004', 'PROD019', 30, '입고', TO_DATE('2024-10-13', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART005', 'PROD020', 50, '출고', TO_DATE('2024-10-28', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART006', 'PROD021', 40, '입고', TO_DATE('2024-11-13', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART007', 'PROD022', 20, '출고', TO_DATE('2024-11-28', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART008', 'PROD023', 10, '입고', TO_DATE('2024-12-14', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART009', 'PROD024', 15, '출고', TO_DATE('2024-12-29', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART010', 'PROD025', 30, '입고', TO_DATE('2025-01-14', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART011', 'PROD026', 20, '출고', TO_DATE('2025-01-29', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART012', 'PROD027', 25, '입고', TO_DATE('2025-02-14', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART013', 'PROD028', 15, '출고', TO_DATE('2025-02-28', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART014', 'PROD029', 40, '입고', TO_DATE('2025-03-15', 'YYYY-MM-DD'));
INSERT INTO TB_ORDERS (order_id, partner_id, product_id, quantity, stock_status, created_at)
VALUES (seq_orders.NEXTVAL, 'PART015', 'PROD030', 20, '출고', TO_DATE('2025-03-30', 'YYYY-MM-DD'));

-- 7. TB_STOCK_HISTORY (30개)
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST001', 'WH001', 'PROD001', 50, 20, '입고', 'EMP002');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST002', 'WH002', 'PROD002', 30, -15, '출고', 'EMP003');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST003', 'WH003', 'PROD003', 60, 10, '입고', 'EMP004');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST004', 'WH004', 'PROD004', 80, -25, '출고', 'EMP005');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST005', 'WH005', 'PROD005', 40, 30, '입고', 'EMP006');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST006', 'WH006', 'PROD006', 70, -20, '출고', 'EMP007');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST007', 'WH007', 'PROD007', 90, 40, '입고', 'EMP008');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST008', 'WH008', 'PROD008', 20, -15, '출고', 'EMP009');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST009', 'WH009', 'PROD009', 100, 50, '입고', 'EMP010');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST010', 'WH010', 'PROD010', 50, -20, '출고', 'EMP011');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST011', 'WH011', 'PROD011', 30, 25, '입고', 'EMP012');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST012', 'WH012', 'PROD012', 40, -10, '출고', 'EMP013');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST013', 'WH001', 'PROD013', 60, 30, '입고', 'EMP014');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST014', 'WH002', 'PROD014', 80, -20, '출고', 'EMP015');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST015', 'WH003', 'PROD015', 20, 5, '입고', 'EMP016');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST016', 'WH004', 'PROD016', 50, -25, '출고', 'EMP017');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST017', 'WH005', 'PROD017', 70, 20, '입고', 'EMP018');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST018', 'WH006', 'PROD018', 40, -15, '출고', 'EMP019');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST019', 'WH007', 'PROD019', 60, 30, '입고', 'EMP020');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST020', 'WH008', 'PROD020', 100, -50, '출고', 'EMP021');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST021', 'WH009', 'PROD021', 80, 40, '입고', 'EMP022');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST022', 'WH010', 'PROD022', 50, -20, '출고', 'EMP023');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST023', 'WH011', 'PROD023', 20, 10, '입고', 'EMP024');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST024', 'WH012', 'PROD024', 60, -15, '출고', 'EMP025');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST025', 'WH001', 'PROD025', 90, 30, '입고', 'EMP002');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST026', 'WH002', 'PROD026', 70, -20, '출고', 'EMP003');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST027', 'WH003', 'PROD027', 40, 25, '입고', 'EMP004');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST028', 'WH004', 'PROD028', 50, -15, '출고', 'EMP005');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST029', 'WH005', 'PROD029', 80, 40, '입고', 'EMP006');
INSERT INTO TB_STOCK_HISTORY (stock_history_id, warehouse_id, product_id, stock_quantity, change_quantity, change_type, created_by)
VALUES ('HIST030', 'WH006', 'PROD030', 60, -20, '출고', 'EMP007');


-- 8. TB_ORDER_STATUS_HISTORY (30개)
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 1, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 2, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 3, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 4, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 5, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 6, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 7, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 8, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 9, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 10, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 11, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 12, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 13, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 14, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 15, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 16, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 17, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 18, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 19, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 20, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 21, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 22, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 23, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 24, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 25, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 26, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 27, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 28, NULL, '출고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 29, NULL, '입고');
INSERT INTO TB_ORDER_STATUS_HISTORY (status_history_id, order_id, prev_stock_status, stock_status)
VALUES (seq_order_status_history.NEXTVAL, 30, NULL, '출고');


-- 9. TB_INOUTVOICE (30개)
-- TB_INOUTVOICE 샘플 데이터 삽입 (30개)
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV001', '입출고전표_001', '입고', 1, 'EMP001', 'WH001', TO_DATE('2024-01-05', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV002', '입출고전표_002', '출고', 2, 'EMP002', 'WH002', TO_DATE('2024-01-15', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV003', '입출고전표_003', '입고', 3, 'EMP003', 'WH003', TO_DATE('2024-02-02', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV004', '입출고전표_004', '출고', 4, 'EMP004', 'WH004', TO_DATE('2024-02-20', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV005', '입출고전표_005', '입고', 5, 'EMP005', 'WH005', TO_DATE('2024-03-10', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV006', '입출고전표_006', '출고', 6, 'EMP006', 'WH006', TO_DATE('2024-03-25', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV007', '입출고전표_007', '입고', 7, 'EMP007', 'WH007', TO_DATE('2024-04-08', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV008', '입출고전표_008', '출고', 8, 'EMP008', 'WH008', TO_DATE('2024-04-22', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV009', '입출고전표_009', '입고', 9, 'EMP009', 'WH009', TO_DATE('2024-05-05', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV010', '입출고전표_010', '출고', 10, 'EMP010', 'WH010', TO_DATE('2024-05-18', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV011', '입출고전표_011', '입고', 11, 'EMP011', 'WH011', TO_DATE('2024-06-03', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV012', '입출고전표_012', '출고', 12, 'EMP012', 'WH012', TO_DATE('2024-06-15', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV013', '입출고전표_013', '입고', 13, 'EMP013', 'WH001', TO_DATE('2024-07-01', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV014', '입출고전표_014', '출고', 14, 'EMP014', 'WH002', TO_DATE('2024-07-12', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV015', '입출고전표_015', '입고', 15, 'EMP015', 'WH003', TO_DATE('2024-07-28', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV016', '입출고전표_016', '출고', 16, 'EMP016', 'WH004', TO_DATE('2024-08-10', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV017', '입출고전표_017', '입고', 17, 'EMP017', 'WH005', TO_DATE('2024-08-22', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV018', '입출고전표_018', '출고', 18, 'EMP018', 'WH006', TO_DATE('2024-09-05', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV019', '입출고전표_019', '입고', 19, 'EMP019', 'WH007', TO_DATE('2024-09-18', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV020', '입출고전표_020', '출고', 20, 'EMP020', 'WH008', TO_DATE('2024-10-02', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV021', '입출고전표_021', '입고', 21, 'EMP021', 'WH009', TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV022', '입출고전표_022', '출고', 22, 'EMP022', 'WH010', TO_DATE('2024-10-28', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV023', '입출고전표_023', '입고', 23, 'EMP023', 'WH011', TO_DATE('2024-11-10', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV024', '입출고전표_024', '출고', 24, 'EMP024', 'WH012', TO_DATE('2024-11-22', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV025', '입출고전표_025', '입고', 25, 'EMP025', 'WH001', TO_DATE('2024-12-05', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV026', '입출고전표_026', '출고', 26, 'EMP026', 'WH002', TO_DATE('2024-12-18', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV027', '입출고전표_027', '입고', 27, 'EMP027', 'WH003', TO_DATE('2025-01-02', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV028', '입출고전표_028', '출고', 28, 'EMP028', 'WH004', TO_DATE('2025-01-15', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV029', '입출고전표_029', '입고', 29, 'EMP029', 'WH005', TO_DATE('2025-02-01', 'YYYY-MM-DD'));
INSERT INTO TB_INOUTVOICE (Inoutvoice_id, Inoutvoice_name, Inoutvoice_type, order_id, worker_id, warehouse_id, created_at)
VALUES ('INV030', '입출고전표_030', '출고', 30, 'EMP030', 'WH006', TO_DATE('2025-02-15', 'YYYY-MM-DD'));



-- TB_STOCK_HISTORY에 Inoutvoice_id 업데이트
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV001' WHERE stock_history_id = 'HIST001';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV002' WHERE stock_history_id = 'HIST002';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV003' WHERE stock_history_id = 'HIST003';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV004' WHERE stock_history_id = 'HIST004';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV005' WHERE stock_history_id = 'HIST005';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV006' WHERE stock_history_id = 'HIST006';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV007' WHERE stock_history_id = 'HIST007';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV008' WHERE stock_history_id = 'HIST008';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV009' WHERE stock_history_id = 'HIST009';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV010' WHERE stock_history_id = 'HIST010';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV011' WHERE stock_history_id = 'HIST011';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV012' WHERE stock_history_id = 'HIST012';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV013' WHERE stock_history_id = 'HIST013';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV014' WHERE stock_history_id = 'HIST014';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV015' WHERE stock_history_id = 'HIST015';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV016' WHERE stock_history_id = 'HIST016';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV017' WHERE stock_history_id = 'HIST017';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV018' WHERE stock_history_id = 'HIST018';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV019' WHERE stock_history_id = 'HIST019';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV020' WHERE stock_history_id = 'HIST020';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV021' WHERE stock_history_id = 'HIST010';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV022' WHERE stock_history_id = 'HIST011';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV023' WHERE stock_history_id = 'HIST012';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV024' WHERE stock_history_id = 'HIST013';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV025' WHERE stock_history_id = 'HIST014';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV026' WHERE stock_history_id = 'HIST015';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV027' WHERE stock_history_id = 'HIST016';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV028' WHERE stock_history_id = 'HIST017';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV029' WHERE stock_history_id = 'HIST018';
UPDATE TB_STOCK_HISTORY SET Inoutvoice_id = 'INV030' WHERE stock_history_id = 'HIST019';



-- 10. TB_APPROVAL_DOCUMENTS (15개)
INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC001', '노트북 입고 승인 요청', '노트북 20개 입고 요청에 대한 승인 문서입니다.', 'EMP002', TO_DATE('2025-05-03', 'YYYY-MM-DD'), '대기', '입고요청서', 1, NULL);
INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC002', '스마트폰 출고 승인 요청', '스마트폰 15개 출고 요청에 대한 승인 문서입니다.', 'EMP003', TO_DATE('2025-05-04', 'YYYY-MM-DD'), '승인', '출고요청서', 2, SYSDATE);
INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC003', '태블릿 입고 승인 요청', '태블릿 10개 입고 요청에 대한 승인 문서입니다.', 'EMP004', TO_DATE('2025-05-05', 'YYYY-MM-DD'), '대기', '입고요청서', 3, NULL);
INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC004', '헤드셋 출고 승인 요청', '헤드셋 25개 출고 요청에 대한 승인 문서입니다.', 'EMP005', TO_DATE('2025-05-06', 'YYYY-MM-DD'), '승인', '출고요청서', 4, SYSDATE);
INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC005', '모니터 입고 승인 요청', '모니터 30개 입고 요청에 대한 승인 문서입니다.', 'EMP006', TO_DATE('2025-05-07', 'YYYY-MM-DD'), '반려', '입고요청서', 5, SYSDATE);
INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC006', '키보드 출고 승인 요청', '키보드 20개 출고 요청에 대한 승인 문서입니다.', 'EMP007', TO_DATE('2025-05-08', 'YYYY-MM-DD'), '대기', '출고요청서', 6, NULL);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC007', '사무용품 구매 품의서', '사무실 프린터 및 잉크 구매 요청: 예상 비용 1,200,000원.', 'EMP007', TO_DATE('2025-05-08', 'YYYY-MM-DD'), '승인', '품의서', NULL, SYSDATE);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC008', 'ABC물산과의 원자재 계약서', '노트북 부품 원자재 공급 계약 체결 요청: 계약 금액 5,000,000원, 기간 2025-06-01 ~ 2025-12-31.', 'EMP008', TO_DATE('2025-05-09', 'YYYY-MM-DD'), '대기', '계약서', 5, NULL);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC009', '신규 마케팅 캠페인 기안서', '2025년 하반기 디지털 마케팅 캠페인 실행 제안: 예상 비용 3,000,000원.', 'EMP009', TO_DATE('2025-05-10', 'YYYY-MM-DD'), '반려', '기안서', NULL, SYSDATE);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC010', '5월 영업 실적 보고서', '2025년 5월 영업부 실적: 매출 50,000,000원, 주요 고객 계약 3건.', 'EMP010', TO_DATE('2025-05-11', 'YYYY-MM-DD'), '승인', '보고서', NULL, SYSDATE);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC011', '프로젝트 팀 빌딩 행사 지출결의서', '프로젝트 팀 빌딩 워크숍 비용 정산: 식비 400,000원, 장소 대여 600,000원.', 'EMP011', TO_DATE('2025-05-12', 'YYYY-MM-DD'), '대기', '지출결의서', NULL, NULL);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC012', '신규 서버 도입 품의서', '데이터 센터 서버 업그레이드 요청: 예상 비용 10,000,000원.', 'EMP012', TO_DATE('2025-05-13', 'YYYY-MM-DD'), '승인', '품의서', NULL, SYSDATE);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC013', 'XYZ전자와의 판매 계약서', '스마트폰 판매 계약 체결 요청: 계약 금액 8,000,000원, 납품일 2025-06-15.', 'EMP013', TO_DATE('2025-05-14', 'YYYY-MM-DD'), '대기', '계약서', 6, NULL);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC014', '재고 관리 프로세스 개선 기안서', '재고 관리 자동화 시스템 도입 제안: 예상 비용 2,500,000원.', 'EMP014', TO_DATE('2025-05-15', 'YYYY-MM-DD'), '대기', '기안서', NULL, NULL);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC015', '1분기 재고 감사 보고서', '2025년 1분기 재고 감사 결과: 불량 재고 5%, 개선 필요.', 'EMP015', TO_DATE('2025-05-16', 'YYYY-MM-DD'), '승인', '보고서', NULL, SYSDATE);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC016', '6월 광고비 지출결의서', '6월 온라인 광고 캠페인 비용 정산: 광고비 1,500,000원.', 'EMP016', TO_DATE('2025-05-17', 'YYYY-MM-DD'), '반려', '지출결의서', NULL, SYSDATE);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC017', 'ERP 시스템 업그레이드 품의서', 'ERP 시스템 최신 버전 업그레이드 요청: 예상 비용 15,000,000원.', 'EMP017', TO_DATE('2025-05-18', 'YYYY-MM-DD'), '대기', '품의서', NULL, NULL);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC018', 'DEF공급처와의 부품 계약서', '태블릿 부품 공급 계약 체결 요청: 계약 금액 6,000,000원, 기간 2025-07-01 ~ 2025-12-31.', 'EMP018', TO_DATE('2025-05-19', 'YYYY-MM-DD'), '승인', '계약서', 7, SYSDATE);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC019', '신제품 출시 계획 기안서', '2025년 하반기 신제품 출시 계획 제안: 예상 비용 4,000,000원.', 'EMP019', TO_DATE('2025-05-20', 'YYYY-MM-DD'), '대기', '기안서', NULL, NULL);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC020', '2분기 매출 분석 보고서', '2025년 2분기 매출 분석: 매출 75,000,000원, 전년 대비 10% 증가.', 'EMP020', TO_DATE('2025-05-21', 'YYYY-MM-DD'), '승인', '보고서', NULL, SYSDATE);


INSERT INTO TB_APPROVAL_DOCUMENTS (doc_id, title, content, emp_id, draft_date, approval_status, document_format, order_id, approval_date)
VALUES ('DOC021', '5월 출장비 지출결의서', '2025년 5월 영업팀 출장 경비 정산 요청: 항공료 500,000원, 숙박비 300,000원.', 'EMP006', TO_DATE('2025-05-07', 'YYYY-MM-DD'), '대기', '지출결의서', NULL, NULL);






-- 11. TB_TRANSACTION_DOCUMENTS (15개)
-- TB_TRANSACTION_DOCUMENTS 샘플 데이터 삽입 (18개)
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '입고계약서1', '입고계약서', '공급처', 'PART001', TO_DATE('2022-01-10', 'YYYY-MM-DD'), 'EMP002', TO_DATE('2024-05-03', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '출고계약서1', '출고계약서', '판매처', 'PART002', TO_DATE('2022-03-15', 'YYYY-MM-DD'), 'EMP003', TO_DATE('2026-05-04', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '입고계약서2', '입고계약서', '공급처', 'PART003', TO_DATE('2022-05-20', 'YYYY-MM-DD'), 'EMP004', TO_DATE('2026-05-05', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '출고계약서2', '출고계약서', '판매처', 'PART004', TO_DATE('2022-07-25', 'YYYY-MM-DD'), 'EMP005', TO_DATE('2023-05-06', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '입고계약서3', '입고계약서', '공급처', 'PART005', TO_DATE('2022-09-30', 'YYYY-MM-DD'), 'EMP006', TO_DATE('2025-05-07', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '출고계약서3', '출고계약서', '판매처', 'PART006', TO_DATE('2022-12-05', 'YYYY-MM-DD'), 'EMP007', TO_DATE('2026-05-08', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '입고계약서4', '입고계약서', '공급처', 'PART007', TO_DATE('2023-02-10', 'YYYY-MM-DD'), 'EMP008', TO_DATE('2024-05-09', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '출고계약서4', '출고계약서', '판매처', 'PART008', TO_DATE('2023-04-15', 'YYYY-MM-DD'), 'EMP009', TO_DATE('2024-05-10', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '입고계약서5', '입고계약서', '공급처', 'PART009', TO_DATE('2023-06-20', 'YYYY-MM-DD'), 'EMP010', TO_DATE('2026-05-11', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '출고계약서5', '출고계약서', '판매처', 'PART010', TO_DATE('2023-08-25', 'YYYY-MM-DD'), 'EMP011', TO_DATE('2026-05-12', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '노트북 납품확인서1', '납품확인서', '공급처', 'PART003', TO_DATE('2023-10-30', 'YYYY-MM-DD'), 'EMP004', TO_DATE('2026-05-05', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '스마트폰 납품확인서1', '납품확인서', '공급처', 'PART004', TO_DATE('2024-01-05', 'YYYY-MM-DD'), 'EMP005', TO_DATE('2026-05-06', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '태블릿 납품확인서1', '납품확인서', '공급처', 'PART005', TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'EMP006', TO_DATE('2026-05-07', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '헤드셋 납품확인서1', '납품확인서', '공급처', 'PART006', TO_DATE('2024-05-15', 'YYYY-MM-DD'), 'EMP007', TO_DATE('2026-05-08', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '출장비 영수증1', '영수증', '공급처', 'PART007', TO_DATE('2024-07-20', 'YYYY-MM-DD'), 'EMP008', TO_DATE('2026-05-09', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '사무용품 영수증1', '영수증', '공급처', 'PART008', TO_DATE('2024-09-25', 'YYYY-MM-DD'), 'EMP009', TO_DATE('2026-05-10', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '광고비 영수증1', '영수증', '공급처', 'PART009', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'EMP010', TO_DATE('2026-05-11', 'YYYY-MM-DD'));
INSERT INTO TB_TRANSACTION_DOCUMENTS (tdoc_id, doc_name, doc_type, related_party_type, related_party_id, uploaded_at, uploaded_by, valid_until)
VALUES (seq_transaction_documents.NEXTVAL, '서버 구매 영수증1', '영수증', '공급처', 'PART010', TO_DATE('2025-02-05', 'YYYY-MM-DD'), 'EMP011', TO_DATE('2024-05-12', 'YYYY-MM-DD'));


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
