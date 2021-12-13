//페이징 html 셋팅
function refreshPaging(totalData, currentPage, grid, gridId) {
    //페이지 사이즈
    const dataPerPage = grid.collectionView.pageSize; // 그리드의 한 페이지당 보여지는 행의 개수
    // 페이지 숫자 목록
    const pageCount = 5;
    //전체 페이지
    const totalPage = Math.ceil(totalData / dataPerPage);
    //페이지그룹
    const pageGroup = Math.ceil(currentPage / pageCount);

    let last = pageGroup * pageCount; // 가장 마지막 인덱스

    if (last > totalPage) {
        last = totalPage;
    }

    let first = last - (pageCount - 1);

    const next = last + 1; // 다음
    var prev = first - 1; // 이전

    if (totalPage < 1) {
        first = last;
    }

    const pages = $('#' + gridId + 'Pager');
    pages.empty();

    // <<  <
    pages.append('<span onClick="clickPager(1, ' + gridId + ', ' + "'" + gridId + "'" + ')" > << </span>');
    if (first > pageCount) {
        pages.append('<span onClick="clickPager(' + prev + ', ' + gridId + ', ' + "'" + gridId + "'" + ')" > ' + '<' + ' </span>');
    } else {
        pages.append('<span onClick="clickPager(1, ' + gridId + ', ' + "'" + gridId + "'" + ')" > ' + '<' + ' </span>');
    }

    // 현재 페이지 인덱스 만큼 append
    for (let j = first; j <= last; j++) {
        if (currentPage === j) {
            pages.append('<span data-page="' + j +'" class="selectPage" id="' + gridId + 'paging_' + j + '" onClick="clickPager(' + j + ', ' + gridId + ', ' + "'" + gridId + "'" + ')" > ' + j + ' </span>');

        } else if (j > 0) {
            pages.append('<span data-page="' + j +'" id="' + gridId + 'paging_' + j + '" onClick="clickPager(' + j + ', ' + gridId + ', ' + "'" + gridId + "'" + ')" > ' + j + ' </span>');

        }
    }

    // >  >>
    if (next > pageCount && next < totalPage) {
        pages.append('<span onClick="clickPager(' + next + ', ' + gridId + ', ' + "'" + gridId + "'" + ')" >  ' + '>' + ' </span>');
    } else {
        pages.append('<span onClick="clickPager(' + totalPage + ', ' + gridId + ', ' + "'" + gridId + "'" + ')" >  ' + '>' + ' </span>');
    }
    pages.append('<span onClick="clickPager(' + totalPage + ', ' + gridId + ', ' + "'" + gridId + "'" + ')" > >> </span>');


    $(".pager").removeClass('wj-control wj-content wj-pager wj-collectionview-navigator wj-state-empty wj-state-readonly');
}



function loadGridUserList(gridBindings, layoutName) {

    var gridView = new wijmo.collections.CollectionView([], {
        pageSize: 30
    });

    var setGridPager = new wijmo.input.CollectionViewNavigator('#setGridPager', {
        byPage: true,
        headerFormat: '{currentPage:n0} / {pageCount:n0}',
        cv: gridView
    });

    var setGrid = new wijmo.grid.FlexGrid('#setGrid', {
        autoGenerateColumns: false,
        alternatingRowStep: 0,
        columns: gridBindings,
        itemsSource: gridView,
        keyActionEnter: "MoveDown",
        imeEnabled: true,
        loadedRows: function (s, e) {
        },
        cellEditEnded: function (s, e) {
            // s.autoSizeColumn(e.col);
        },
        rowEditEnded: function (s, e) {
            // s.autoSizeColumns();
        },
        itemFormatter: function (p, r, c, cell) {

            if (p.cellType == wijmo.grid.CellType.RowHeader) {
                //cell.textContent = (r+1).toString();
                cell.textContent = (gridView.pageSize * gridView.pageIndex + r + 1).toString();
            }

            var numberFormat = $(".number-format");
            $.each(numberFormat, function (i, el) {
                var result = Number($(el).text());
                if (typeof result == 'number') {
                    $(el).text(result.toLocaleString()).removeClass("number-format");
                }
            })


        }
    });


    _setUserGridLayout(layoutName, setGrid, gridBindings);
    refreshPaging(setGrid.collectionView.totalItemCount, 1, setGrid, 'setGrid');  // 페이징 초기 셋팅

    return {
        setGrid,
        setGridPager,
        gridView
    }
}



function loadGridUserListTargetFocus(gridBindings, layoutName, targetObject) {

    var gridView = new wijmo.collections.CollectionView([], {
        pageSize: 30
    });

    var setGridPager = new wijmo.input.CollectionViewNavigator(targetObject.setGridPager, {
        byPage: true,
        headerFormat: '{currentPage:n0} / {pageCount:n0}',
        cv: gridView
    });

    var setGrid = new wijmo.grid.FlexGrid(targetObject.setGrid, {
        autoGenerateColumns: false,
        alternatingRowStep: 0,
        columns: gridBindings,
        itemsSource: gridView,
        keyActionEnter: "MoveDown",
        imeEnabled: true,
        loadedRows: function (s, e) {
        },
        cellEditEnded: function (s, e) {
            // s.autoSizeColumn(e.col);
        },
        rowEditEnded: function (s, e) {
            // s.autoSizeColumns();
        },
        itemFormatter: function (p, r, c, cell) {

            if (p.cellType == wijmo.grid.CellType.RowHeader) {
                //cell.textContent = (r+1).toString();
                cell.textContent = (gridView.pageSize * gridView.pageIndex + r + 1).toString();
            }
        }
    });

    _setUserGridLayout(layoutName, setGrid, gridBindings);
    refreshPaging(setGrid.collectionView.totalItemCount, 1, setGrid, targetObject.setGrid.replace("#", ""));  // 페이징 초기 셋팅

    return {
        setGrid,
        setGridPager,
        gridView
    }
}



//팝업 오픈
function showPop(pop){
    if(pop == "new_staff"){


    }else if(pop == "modify_staff"){


    }else if(pop == "image"){

        var imgPath = setGrid.collectionView.currentItem["idprofile"]
        var img = '<img class="comment_img" src="'+imgPath+'"alt="이미지">';
        $('#imgPath').append(img)

    }

    $('#'+pop).addClass('is-visible');
}



//페이지 클릭이벤트
function clickPager(idx, grid, gridId) {

    var query_string = new URLSearchParams(window.location.search);

    if (query_string.has('page')) {
        query_string.set("page", idx)
    } else {
        query_string.append("page", idx);
    }

    document.searchForm.page.value = idx;
    makeUrlHistoryPoint({ path: query_string.toString() });
    grid.collectionView.moveToPage(idx - 1); // 그리드 0부터 시작
    refreshPaging(grid.collectionView.totalItemCount, idx, grid, gridId); // 그리드의 전체 아이템 수, 클릭한 인덱스 값 넘겨주기
}



//회원 리스트 조회
function perPage(count) {
    setGrid.beginUpdate();
    gridView.pageSize = Number(count);
    setGrid.endUpdate();

    var query_string = new URLSearchParams(window.location.search);

    if (query_string.has('perPage')) {
        query_string.set("perPage", count)
    } else {
        query_string.append("perPage", count)
    }

    makeUrlHistoryPoint({ path: query_string.toString() });
    refreshPaging(setGrid.collectionView.totalItemCount, 1, setGrid, 'setGrid');  // 페이징 초기 셋팅
}



//그리드 초기 레이아웃 복원
function _resetUserGridLayout(layoutId, grid, initColumns) {

    grid.columns.clear();
    initColumns.forEach((col) => {
        grid.columns.push(new wijmo.grid.Column(col));
    });

    localStorage.setItem(layoutId, grid.columnLayout);
    alert("컬컴위치를 초기화하였습니다.");
    _setUserGridLayout(layoutId, grid, initColumns);
}

//그리드 레이아웃 저장
function _getUserGridLayout(layoutId, grid) {
    alert("컬럼위치를 저장하였습니다.");
    localStorage.setItem(layoutId, grid.columnLayout);
}



//그리드 레이아웃 복원
function _setUserGridLayout(layoutId, grid, initColumns) {

    if (window.localStorage[layoutId]) {
        let columnsArr = JSON.parse(window.localStorage[layoutId]).columns;

        grid.columns.clear();
        columnsArr.forEach((col) => {
            initColumns.forEach((col2) => {
                if (col.binding == col2.binding) {
                    grid.columns.push(new wijmo.grid.Column(col2));
                }
            });
        });
    }

}

function exportExcel(filename){

    var serGridCollectionView = setGrid.collectionView;
    var oldPgSize = serGridCollectionView.pageSize;
    var oldPgIndex = serGridCollectionView.pageIndex;

    //전체 데이터를 엑셀다운받기 위해서는 페이징 제거 > 엑셀 다운 > 페이징 재적용 하여야 함.
    setGrid.beginUpdate();
    gridView.pageSize = 0;

    wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync(setGrid, {includeCellStyles: true, includeColumnHeaders: true}, filename + '.xlsx',
        saved => {
            serGridCollectionView.pageSize = oldPgSize;
            serGridCollectionView.moveToPage(oldPgIndex);
            setGrid.endUpdate();
        }, null
    );

}


// 뒤로가기 포인트 만들기
function makeUrlHistoryPoint(data) {
    var title = data.title ?? document.title;
    var path = data.path ?? "";

    window.history.pushState({}, title, "?" + path);
}

// window.onpopstate = function (e) {
//     var query_string = new URLSearchParams(window.location.search);
//     const params = paramsToObject(query_string.entries());
//     console.log(params);
// }



//팝업 종료
function closePop(){
    $('#imgPath').empty();
    $('.popup').removeClass('is-visible');
}



function paramsToObject(entries) {
    const result = {}
    for(const [key, value] of entries) {
        result[key] = value;
    }
    return result;
}

/* 뒤로가기 처리 (미완성) */
window.onpopstate = function (e) {
    var query_string = new URLSearchParams(window.location.search);
    const params = paramsToObject(query_string.entries());
    const f = document.searchForm;

    for (key in params) {
        if (typeof f[key] == "undefined") continue
        f[key].value = params[key];
        console.log(f[key].value + "::" + key);
    }

    // getProjectList();
}

/* 전체/진행중/종료 선택 */
function processTypeChanger(_value, callback) {
    var f = document.searchForm;
    f.active.value = _value
    callback()
}

function modalPop(ctx, target=false) {

    var modal;
    if (target) {
        modal = target;
    } else {
        modal = $(".modal.edit_modal");
    }

    var opacity = modal.css("opacity");
    $(".btn_style01.create").css("display", "none");
    $(".btn_style01.update").css("display", "inline-block");


    if (opacity == "1") { // 모달끄기
        modal.css({
            opacity: 0,
            visibility: "hidden"
        })
    } else { // 모달켜기
        var item = ctx.item;

        modal.css({
            opacity: 1,
            visibility: "visible"
        })

        var f = document.modifyForm;

        for (let key in item) {
            if (typeof item[key] == null
                || typeof item[key] == 'undefined'
                || typeof f[key] == 'undefined'
            ) continue
            f[key].value = item[key];
        }

    }

    setTimeout(function () {

        $(".modal-form-title.create", modal).css("display", "none");
        $(".modal-form-title.modify", modal).css("display", "block");

    }, 500)


}



function showDateRange(s, _el) {
    let el = document.querySelector(_el);
    el.textContent = wijmo.format('from {value:d} to {rangeEnd:d}', s);
}

// get predefined date ranges
function getPredefinedRanges() {
    let dt = wijmo.DateTime, now = new Date();
    return {
        // custom
        '선택': null,
        // days
        //'Today': [now, now],
        //'Yesterday': [dt.addDays(now, -1), dt.addDays(now, -1)],
        //'Tomorrow': [dt.addDays(now, +1), dt.addDays(now, +1)],
        // weeks
        '이번주': [dt.weekFirst(now), dt.weekLast(now)],
        '지난주': [dt.weekFirst(dt.addDays(now, -7)), dt.weekLast(dt.addDays(now, -7))],
        '다음주': [dt.weekFirst(dt.addDays(now, +7)), dt.weekLast(dt.addDays(now, +7))],
        // months
        '이번달': [dt.monthFirst(now), dt.monthLast(now)],
        '지난달': [dt.monthFirst(dt.addMonths(now, -1)), dt.monthLast(dt.addMonths(now, -1))],
        '다음달': [dt.monthFirst(dt.addMonths(now, +1)), dt.monthLast(dt.addMonths(now, +1))],
        // years
        '올해': [dt.yearFirst(now), dt.yearLast(now)],
        '작년': [dt.addYears(dt.yearFirst(now), -1), dt.addYears(dt.yearLast(now), -1)],
        '내년': [dt.addYears(dt.yearFirst(now), +1), dt.addYears(dt.yearLast(now), +1)],
    };
}

function MyCustomUploadAdapterPlugin(editor) {
    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
        return new UploadAdapter(loader)
    }
}

//이미지업로드
class UploadAdapter {
    constructor(loader) {
        this.loader = loader;
    }

    upload() {
        return this.loader.file.then( file => new Promise((async (resolve, reject) => {
            await this._initRequest();
            await this._initListeners(resolve, reject, file);
            await this._sendRequest(file);
        })))
    }

    abort() {
        if ( this.xhr ) { this.xhr.abort(); }
    }

    _initRequest() {
        const xhr = this.xhr = new XMLHttpRequest();
        xhr.open('POST', '/cms/editor/upload', true);
        xhr.responseType = 'json';
    }

    async _initListeners(resolve, reject, file) {
        const xhr = this.xhr;
        const loader = this.loader;
        const genericErrorText = '파일을 업로드 할 수 없습니다. \n파일용량은 3MB를 초과할수 없습니다.'

        await xhr.addEventListener('error', () => {reject(genericErrorText)})
        await xhr.addEventListener('abort', () => reject())
        await xhr.addEventListener('load', () => {
            const maxSize = 3500000;
            const response = xhr.response

            if(!response || response.error ||file.size > maxSize) {
                return reject( response && response.error ? response.error.message : genericErrorText );
            }

            resolve({
                default: response.url //업로드된 파일 주소
            })
        })
    }

    _sendRequest(file) {
        const data = new FormData()
        data.append('file', file);
        this.xhr.send(data)
    }
}


async function setEditor() {

    var _editor;

    await ClassicEditor
        .create( document.querySelector( '#content' ), {

            toolbar: {
                items: [
                    'heading',
                    '|',
                    'bold',
                    'italic',
                    'link',
                    'bulletedList',
                    'numberedList',
                    '|',
                    'outdent',
                    'indent',
                    '|',
                    'imageUpload',
                    'blockQuote',
                    'insertTable',
                    'mediaEmbed',
                    'undo',
                    'redo',
                    'htmlEmbed',
                    'horizontalLine',
                    'fontSize',
                    'fontColor',
                    'fontBackgroundColor',
                    'alignment',
                ],
                shouldNotGroupWhenFull: true
            },
            language: 'ko',
            image: {
                toolbar: [
                    'imageTextAlternative',
                    'imageStyle:inline',
                    'imageStyle:block',
                    'imageStyle:side'
                ]
            },
            table: {
                contentToolbar: [
                    'tableColumn',
                    'tableRow',
                    'mergeTableCells'
                ]
            },
            extraPlugins: [MyCustomUploadAdapterPlugin],
            licenseKey: '',



        })
        .then( editor => {
            editor.plugins.get('FileRepository').createUploadAdapter = (loader)=>{
                return new UploadAdapter(loader);
            };
            _editor = editor

        })
        .catch( error => {
            console.error( 'Oops, something went wrong!' );
            console.error( 'Please, report the following error on https://github.com/ckeditor/ckeditor5/issues with the build id and the error stack trace:' );
            console.warn( 'Build id: d7cnhvir6n7w-iy62in32ou41' );
            console.error( error );
        });

    return _editor;
}