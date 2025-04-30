<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 상품관리 메뉴의 active 클래스를 제거
        const productMenu = document.querySelector('.nav-link.dropdown-toggle[data-bs-toggle="dropdown"]');
        if (productMenu) {
            productMenu.classList.remove('active');
        }
        
        // 재고관리 메뉴에 active 클래스 추가
        const inventoryMenu = document.querySelector('.nav-link.dropdown-toggle[data-bs-toggle="dropdown"]:nth-child(6)');
        if (inventoryMenu) {
            inventoryMenu.classList.add('active');
        }
    });
</script> 