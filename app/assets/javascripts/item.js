$(function(){

  //画面の初期化処理
  $(".item-images__field__input label").not(":first").remove();
  $("input[type=file]").val("");

  //--カテゴリー処理---------------------------------
  function buildCategory(categories,dom){
    if (dom.attr("id") == "product_category1"){
      var insert_category = "category2"
    } else if (dom.attr("id") == "product_category2"){
      var insert_category = "category_id"
      $("#category3").empty();
    }
    var html = `
      <div class="input-select">
        <select name="product[${insert_category}]" id="product_${insert_category}"><option value="">選択してください</option>`
    $.each(categories, function(i, category) {
      html += `<option value="${category.id}">${category.name}</option>`
    });
    html += `
        </select>
        <svg aria-hidden="true" fill-rule="evenodd" fill="#888888" height="24" viewBox="0 0 24 24" width="24">
          <path d="M12,15.66a1.73,1.73,0,0,1-1.2-.49L5.21,9.54a.7.7,0,0,1,1-1l5.62,5.62c.15.15.27.15.41,0L17.8,8.6a.71.71,0,0,1,1,0,.69.69,0,0,1,0,1l-5.57,5.58A1.71,1.71,0,0,1,12,15.66Z"></path>
        </svg>
      </div>`
    return html
  }
  function setCategory(dom){
    var select_idx =  dom.prop("selectedIndex")
    var select_value = dom.val();
    if (select_idx > 0){
      var formData = {parent_id: select_value};
      var url = "/items/api/category"
      $.ajax({
        url: url,
        type: 'GET',
        data: formData,
        dataType: 'json',
      })
      .done(function(categories) {
        if (categories.length !== 0) {
          var insertHTML = '';
          insertHTML += buildCategory(categories,dom);
          if (dom.attr("id") == "product_category1"){
            $('#category2').append(insertHTML);
          } else if(dom.attr("id") == "product_category2"){
            $('#category3').append(insertHTML);
          }
        }
      })
      .fail(function() {
        alert("カテゴリー取得に失敗しました");
      })
      .always(function(){

      });
    } else {
      return false;
    }
  }

  $("#product_category1").change(function(e){
    e.preventDefault();
    $("#category2").empty();
    $("#category3").empty();
    setCategory($(this));
  })
  $(document).on("change","#product_category2",function(e){
    e.preventDefault();
    $("#category3").empty();
    setCategory($(this));
  })
  //---------------------------------------------

  //--プレビュー---------------------------------
  //イメージプレビュー用の処理
  // 画像用のinputを生成する関数
  function buildPreview(index, url){
    const html = `
      <div class="preview" id="preview-${index}">
        <img data-index="${index}" src="${url}" >
        <a href="#" class="delete-preview" id="delete-preview-${index}" data-index="${index}" >
          削除
        </a>
      </div>
      `;
    return html;
  }
function buildFilefield(index){
    const html = `
    <label id="input-${index}">
      <input type="file" 
        name="product[product_images_attributes][${index}][image_name]" 
        id="product_product_images_attributes_${index}_image_name">
    </label>
      `;
    return html;
  }
  

  let imagesCount = 0;
  let addCount = 0;
  //DataTransferオブジェクトで、データを格納する箱を作る
  //querySelectorでfile_fieldを取得
  $(document).on('change',"input[type=file]", function(e){
    // //ファイルオブジェクトを取得する
    var file = $(this).prop('files')[0];

    imagesCount += 1;
    addCount += 1;
    $('.item-images__field__input').append(buildFilefield(addCount));
    $(`#product_product_images_attributes_${addCount}_image_name`).after($(".file-area").first().clone());


    // 末尾の数に1足した数を追加する
    blobUrl = window.URL.createObjectURL(file)

    // fileIndexの先頭の数字を使ってinputを作る
    if (imagesCount <= 5){
      $('.item-images__field__previews--first').append(buildPreview(addCount,blobUrl));
    } else {
      $('.item-images__field__previews--second').append(buildPreview(addCount,blobUrl));
    }
    setPreviewClass(imagesCount);
  });

  function setPreviewClass(imagesCount){
    firstDiv = ".item-images__field__previews--first"
    secondDiv = ".item-images__field__previews--second"

    //仕様
    //画像のサイズ調整currentClass + ' .preview'
    //  100 50 33 25 20 の段階調整
    //プレビュー枠のサイズ調整currentClass
    //  20 40 60 80 100 の段階調整
    //input枠のサイズ調整.item-images__field__input
    //  100 80 60 40 20 の段階調整
    //  5で割ったあまりの数に応じてサイズ調整

    //input枠のサイズ調整.item-images__field__input
    //調整用のクラス名を削除
    $('.item-images__field__input').removeClass(function(index, className) {
      return (className.match(/\bfield-width--\S+/g) || []).join(' ');
    });
    if (imagesCount % 5 == 1){
      $('.item-images__field__input').addClass('field-width--1');
    } else if (imagesCount % 5 == 2){
      $('.item-images__field__input').addClass('field-width--2');
    } else if (imagesCount % 5 == 3){
      $('.item-images__field__input').addClass('field-width--3');
    } else if (imagesCount % 5 == 4){
      $('.item-images__field__input').addClass('field-width--4');
    } else if (imagesCount % 5 == 0){
      $('.item-images__field__input').addClass('field-width--0');
    }

    //プレビュー枠のサイズ調整
    $(firstDiv).removeClass(function(index, className) {
      return (className.match(/\bimages-count--\S+/g) || []).join(' ');
    });
    $(secondDiv).removeClass(function(index, className) {
      return (className.match(/\bimages-count--\S+/g) || []).join(' ');
    });
    if (imagesCount > 5) {
      //画像が5枚より多い
      $(secondDiv).addClass(`images-count--${imagesCount % 5}`);
    } else {
      //画像が５枚以下
      $(firstDiv).addClass(`images-count--${imagesCount % 5}`);
    }

    //画像のサイズ調整currentClass + ' .preview'
    $(firstDiv + " .preview").removeClass(function(index, className) {
      return (className.match(/\bpreview-width--\S+/g) || []).join(' ');
    });
    $(secondDiv + " .preview").removeClass(function(index, className) {
      return (className.match(/\bpreview-width--\S+/g) || []).join(' ');
    });
    if (imagesCount > 5) {
      $(secondDiv + ' .preview').addClass(`preview-width--${imagesCount % 5}`);
      $(firstDiv + ' .preview').addClass(`preview-width--0`);
    } else {
      $(firstDiv + ' .preview').addClass(`preview-width--${imagesCount % 5}`);
    }
    if (imagesCount == 10){
      $('.file-area').css('display', 'none')   
    } else {
      $('.file-area:last').css('display', 'flex')
    }
  }

  $(document).on('click',".delete-preview",function(e){
    e.preventDefault()
    
    index = $(this).data("index");
    current = $(this)
    parent = current.parent().parent()
    imagesCount -= 1;
    $(`#input-${index -1}`).remove();
    $(`#preview-${index}`).remove();
    //もし１行目のプレビュー枠から削除した場合、２行目から１個持ってくる
    if (parent.attr("id") == $("#item-images__field__previews--first").attr("id")){
      $("#item-images__field__previews--second .preview:first").appendTo($(".item-images__field__previews--first"));
    }
    setPreviewClass(imagesCount);
  });
  //---------------------------------------------
  //--手数料計算---------------------------------
  $(document).on('change', '#product_price', function() {
    const rate = 10;
    let price = Number(nvl($(this).val()),0);
    let fee = Math.ceil(price * (rate / 100));
    let profit = price - fee;
    $(".item-fee__price p").text("¥" + fee);
    $(".item-profit__price p").text("¥" + profit);
  });
  function nvl(val1, val2){
    return (val1 == null)?val2:val1;
  }
  //---------------------------------------------
});
