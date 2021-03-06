/*
全局变量
window.imgSourceRight
window.tmp
window.imgSourceLeft
window.imgSrcLeft
window.imgSrcRight
window.src


尽量避免使用或重新赋值以上变量
*/

$(function(){
	//图片加载完成居中以及左右主题对齐
	$(window).load(function(){
		setImgCenter();
		keepAlign();
	})
	
	//微博图片获得焦点
	function setImgCenter(){
		for (var i = 0; i < $('.images img').length; i++) {
			if ($('.images img').eq(i).width() > 120) {
				$('.images img').eq(i).css('left', -($('.images img').eq(i).width() - 120) / 2);
			} else {
				$('.images img').eq(i).width(120);
			}
			if ($('.images img').eq(i).height() > 120) {
				$('.images img').eq(i).css('top', -($('.images img').eq(i).height() - 120) / 2);
			} else {
				$('.images img').eq(i).height(120);
			}
		}
	}
	
	//图片点击放大
	$('.weibo_content').on('click','.oneImage img',function(){
		$(this).parent().hide();
		$(this).parent().next('.image_zoom').show();
		var obj=$(this).parent().next('.image_zoom').find('img')
		obj.attr('src',obj.attr('source'));
		keepAlign();
	})
	//图片点击缩小
	$('.weibo_content').on('click','.image_zoom_in',function(){
		$(this).parent().parent().parent().hide();
		$(this).parent().parent().parent().prev('.oneImage').show();
		keepAlign();
	})
	
	//微博输入检测
	$('.button').button();
	$('.text').on('keyup',function(){
		checkStrLen(this);
	})
	$('.text').on('focus',function(){
		checkStrLen(this);
	})
	//发布微博
	$('.weibo_form .button').click(function(){
		var imgPool=[],
			img=$('input[name="images"]'),
			len=img.length;
		for(var i=0;i<len;i++){
			imgPool.push($(img[i]).val());
		}
		if(imgPool.length >0 && $('.text').val()==''){
			
			$("textarea[name='content']").val('分享图片');
		}
		
		if($('.text').val()==''){
			$('#msg').css('background','url('+THINKPHP['img']+'/error.png) no-repeat 18px 8px').html('您还没有分享新鲜事呀！').dialog('open');
			setTimeout(function(){
				$('#msg').html('...').dialog('close');
				$('.text').focus();
			},1500)
		}else{		
			if(checkStrLen($('.text').get(0))){
				var imgPool=[],
				img=$('input[name="images"]'),
				len=img.length;
			for(var i=0;i<len;i++){
				imgPool.push($(img[i]).val());
			}
				
				$.ajax({
					url:THINKPHP['module']+'/Topic/publish',
					type:'post',
					data:{
						content:$('textarea.text').val(),
						images:imgPool,
					},
					beforeSend:function(){
						$('#msg').css({
							'background':'url('+THINKPHP['img']+'/loading.gif) no-repeat 18px 8px',
						}).html('正在提交中，请稍等...').dialog('open');
					},
					success:function(text){
						resetCount.clear();
						$('.weibo_pic_content').remove();
						$("input[name='images']").remove();						
						$('.pic_arrow_top').fadeOut();
						$('#pic_box').fadeOut();
						var html=''
						switch(imgPool.length){
							case 0:
								html=$('.ajax_none_pic').html();
								break;
							case 1:
								html=$('.ajax_single_pic').html()
								break;
							default:
								THINKPHP["muti_pic"]=[]
								for(var i=imgPool.length-1;i>=0;i--){
									$('.ajax_muti_pic p').after('<div class="images"> <img class="show_unfold_pic" src="'+THINKPHP['root']+'/'+ $.parseJSON(imgPool[i])['thumb']+'" key="muti_pic" alt="" unfold="'+THINKPHP['root']+'/'+ $.parseJSON(imgPool[i])['unfold']+'" source="'+THINKPHP['root']+'/'+ $.parseJSON(imgPool[i])['source']+'" /> </div>')
									THINKPHP["muti_pic"].push(THINKPHP['root']+"/"+$.parseJSON(imgPool[i])['source'])
									THINKPHP["muti_pic"].push(THINKPHP['root']+"/"+$.parseJSON(imgPool[i])['unfold'])
								}
								html=$('.ajax_muti_pic').html()
								
						}
						if(html.indexOf('#内容#')){
							var str=$("textarea[name='content']").val()+' '
							html=html.replace(/#内容#/g,str.replace(/(@\S+)\s/i,'<a href="'+THINKPHP['root']+'/$1" class="space" target="_blank" >$1</a>'))
						}
						if(html.indexOf('图片地址')){
							if (imgPool.length > 0) {
								var imgObj = $.parseJSON(imgPool[0])
								html = html.replace(/#图片地址#/g, THINKPHP['root'] + '/' + imgObj['thumb'])
								html = html.replace(/#原图地址#/g, THINKPHP['root'] + '/' + imgObj['source'])
								html = html.replace(/#显示地址#/g, THINKPHP['root'] + '/' + imgObj['unfold'])
								
							}
						}
						
						html = html.replace(/\[(a|b|c|d)_([0-9]+)\]/g,'<img src="'+THINKPHP['img']+'/face/$1/$2.gif" border="0">')
						
						$('#msg').css('background','url('+THINKPHP['img']+'/success.gif) no-repeat 18px 8px').html('发表成功！').dialog('open');
						setTimeout(function(){
							$('.weibo_content ul').after(html);
							$("textarea[name='content']").val('');
							$('#msg').html('...').dialog('close');
							
							setUrl(); 
							
						},1500)
						
					}
				})
				
			}else{
				$('#msg').css('background','url('+THINKPHP['img']+'/error.png) no-repeat 18px 8px').html('您写的太多了！').dialog('open');
				setTimeout(function(){
					$('#msg').html('...').dialog('close');
					$('.text').focus();
				},1500)
			
			}
		}
	})
	//多图浏览放大
	$('#images_zoom').dialog({
		minWidth:580,
		minHeight:20,
		autoOpen:false,
		modal:true,
		resizable:false,
		draggable:false,
		closeOnEscape:true,
	}).parent().find('.ui-widget-header').hide();
	$('#images_zoom').dialog('widget').css({
		'background':'#fafafa',
		'position' : 'fixed',
		'z-index' : 10000,		
	})
	//多图点击弹出
	$('.weibo_content ').on('click','.show_unfold_pic',function(){
		var _this=this,		
		sourceSrc=$(this).attr('source'),
		key=$(this).attr('key')
		
		window.src=$(this).attr('unfold')
		
		imgLoadEvent(function(obj){
				$('#images_zoom').dialog('open').dialog({
					height: obj.h + 60,
				})
				$('#images_zoom img').attr('src', src)
				$('#images_zoom .image_zoom_source').attr('href',sourceSrc)
				var top = $('#images_zoom').dialog('widget').position().top, left = $('#images_zoom').dialog('widget').position().left;
				$('.image_close').css({
					'position': 'fixed',
					'left': left + 570,
					'top': top - 12,
					'z-index': 10001,
					'display': 'block',
				}).click(function(){
					$(this).hide();
					$('#images_zoom').dialog('close');
				})
				//显示图片翻页
				$('#images_zoom .left,#images_zoom .right').css({
					top: $('#images_zoom').dialog('option', 'height') / 2 - 35,
					'height': 70,
					'border-radius': 8,
					'border-radius': 8,
					'width': 150,
				})
//				.hover(function(){
//					$(this).stop().animate({
//						opacity: 0.7,
//					})
//				}, function(){
//					$(this).stop().animate({
//						opacity: 0,
//					})
//				})
				//图片翻页
//				window.imgSourceRight = THINKPHP[key].concat([]),
//				window.tmp=THINKPHP[key].concat([]), 
//				window.imgSourceLeft = tmp.reverse(),
//				window.imgSrcLeft='',
//				window.imgSrcRight=''	
				
			}, src);
		
	})	
//	//左右翻图
//	$('#images_zoom ').on('click','.left',function(){				
//		imgSrcLeft= imgSrcLeft ? imgSrcLeft : src
//		$(imgSourceLeft).each(function(i, v){
//			if (v == imgSrcLeft) {														
//				if(i==imgSourceLeft.length-2){
//					var url=imgSourceLeft[0],
//					sourceUrl=imgSourceLeft[1]
//				}else{
//					var url=imgSourceLeft[i+2],
//					sourceUrl=imgSourceLeft[i+2]
//				}								
//				pic(url,sourceUrl)
//				imgSrcLeft=url
//				keepAlign();
//				return false;							
//			}
//		})
//	})
//	$('#images_zoom ').on('click','.right',function(){
//		
//		$(imgSourceRight).each(function(i, v){
//			imgSrcRight= imgSrcRight ? imgSrcRight : src						
//			if (v == imgSrcRight) {					
//				if(i==imgSourceRight.length-1){
//					var url=imgSourceRight[1],
//					sourceUrl=imgSourceRight[0]
//				}else{
//					var url=imgSourceRight[i+2],
//					sourceUrl=imgSourceRight[i+2]
//				}
//				pic(url,sourceUrl)
//				imgSrcRight=url;
//				keepAlign();
//				return false;
//			}
//		})
//	})
	
	//每页显示数据量
	window.unit=10
	//第几条数据
	window.start=10
	//当前页码
	window.count=1
	//是否禁用滚动条事件
	window.flag=true
	
	//ajax获得页码
	$.ajax({
		url:THINKPHP['module']+'/Topic/ajaxPages',
		type:'post',
		data:{
			unit:window.unit,
		},
		success:function(data,response,state){
			//总页码
			window.pages=parseInt(data)
		},		
	})
	//ajax加载更多
	$(window).scroll(function(){
		if(window.count<window.pages){
			if(window.flag){
				if($(window).scrollTop()>$('#loadmore').offset().top+$('#loadmore').outerHeight(true)-$(window).height()){
					setTimeout(function(){
						$.ajax({
							url:THINKPHP['module']+'/Topic/ajaxList',
							type:'POST',
							data:{
								start:window.start,
								step:window.unit,
							},
							beforeSend:function(){},
							success:function(data,response,status){								
								$('#loadmore').before(data)
								keepAlign();
								setUrl();
							}							
						})
						window.flag=true
						window.start += 10
						window.count += 1						
					},500)
					window.flag=false	
				}		
			}
		}else{
			$('#loadmore').html('数据加载完毕')
		}	
	})
	//返回顶部
	$.scrollUp({
		scrollName: 'scrollUp', // Element ID
		topDistance: '300', // Distance from top before showing element (px)
		topSpeed: 300, // Speed back to top (ms)
		animation: 'fade', // Fade, slide, none
		animationInSpeed: 200, // Animation in speed (ms)
		animationOutSpeed: 200, // Animation out speed (ms)
		scrollText: '', // Text for element
		activeOverlay: false, // Set CSS color to display scrollUp active
	});
	
	//解析@会员功能
	setUrl();
	//回复转发功能
	$('.weibo_content').on('click','.re',function(){
		var re=$(this).parent().parent().find('.re_box');
		if(re.is(':hidden')){			
			$('.re_box').hide();
			$('.comm_box').hide();
			re.find('.re_button').button().click(function(){
				$.ajax({
					url:THINKPHP['module']+'/Topic/re_topic',
					type:'post',
					data:{
						reid:re.find('input[name="reid"]').val(),
						content:re.find('.re_text').val(),
					},
					beforeSend:function(){
						$('#msg').css({
							'background':'url('+THINKPHP['img']+'/loading.gif) no-repeat 18px 8px',
						}).html('正在转发中，请稍等...').dialog('open');
					},
					success:function(data,response,status){
						if(data){
							$('#msg').css('background','url('+THINKPHP['img']+'/success.gif) no-repeat 18px 8px').html('发表成功！').dialog('open');
							setTimeout(function(){
								$('#msg').dialog('close');
								re.find('.re_text').val('')
								location.reload(true);
							},500);
						}					
						
					}
				})
			});
			
			re.show();
			re.find('.re_text').focus();
		}else{
			re.hide();
		}		
	})
	//点击切换评论
	$('.weibo_content').on('click','.comment',function(){
		var comment=$(this).parent().parent().find('.comm_box');
		var re=$(this).parent().parent().find('.re_box');
		if (comment.is(':hidden')) {
			$('.comm_box').hide();
			$('.re_box').hide();
			comment.show();
			comment.find('.comm_text').focus();
			
			var tid=$(this).parent().parent().find('input[name="tid"]').val(),
			comment_content=$(this).parent().parent().find('.comment_content');
			//加载评论
			$.ajax({
				url : THINKPHP['module'] + '/Comment/getList',
				type : 'POST',
				data : {
					tid : tid,
					page : 1,
				},
				beforeSend : function () {
					//加载中。。。
					comment_content.append('<p style="text-align:center;">评论加载中<img src="' + THINKPHP['img'] + '/loadmore.gif" alt=""></p>');
				},
				success : function(data, response, status){
					if (data) {
						//删除子节点所有评论
						comment_content.find('*').remove();
						//添加评论内容
						comment_content.append(data);
						//@帐号
						setUrl();
					}
				}
			});
		}else{
			comment.hide();
		}
	})
	
	//评论分页点击
	$('.comm_box').on('click', '.page_comment', function () {
		var page = $(this).attr('page');
		var comment_content = $(this).parent().parent().parent().find('.comment_content');
		var tid = $(this).parent().parent().parent().find('input[name="tid"]').val();
		//删除子节点所有评论
		comment_content.find('*').remove();
		$.ajax({
			url : THINKPHP['module'] + '/Comment/getList',
			type : 'POST',
			data : {
				tid : tid,
				page : page,
			},
			beforeSend : function () {
				//加载中。。。
				comment_content.append('<p style="text-align:center;">评论加载中<img src="' + THINKPHP['img'] + '/loadmore.gif" alt=""></p>');
			},
			success : function(data, response, status){
				if (data) {
					//删除子节点所有评论
					comment_content.find('*').remove();
					//添加评论内容
					comment_content.append(data);
					//@帐号
					setUrl();
				}
			}
		});
	})
	//评论按钮
	$('.comm_button').button()
	$('body').on('click','.comm_button',function(){
		var tid=$(this).parent().find('input[name="tid"]').val(),
		content=$(this).parent().find('textarea[name="comment"]').val(),
		comment=$(this).parent().find('textarea[name="comment"]')
		
		//ajax提交至服务器
		$.ajax({
			url:THINKPHP['module']+'/Comment/publish',
			type:'post',
			data:{
				tid:tid,
				content:content,
			},
			beforeSend:function(){
				$('#msg').css({
					'background':'url('+THINKPHP['img']+'/loading.gif) no-repeat 18px 8px',
				}).html('正在提交中，请稍等...').dialog('open');
			},
			success:function(data,response,status){
				if(data){							
					$('#msg').css('background','url('+THINKPHP['img']+'/success.gif) no-repeat 18px 8px').html('评论成功！').dialog('open');
					setTimeout(function(){
						$('#msg').dialog('close');
						comment.find('.comm_text').val('')
						location.reload(true);
					},500);
				}
			}
		})
	})

				
})


//解析@会员功能
function setUrl(){
	$(document).ready(function(){
		$('.weibo_content').find('.space').each(function(i){
			var username=$(this).text().substr(1);
			var _this=this;		
			if($(this).attr('flag') != 'true'){
				$.ajax({
					url:THINKPHP['module']+'/Space/setUrl',
					async:false,
					type:'post',
					data:{
						'username':username
					},
					success:function(data){
						if(data){
							$(_this).attr('href',THINKPHP['root']+'/june/'+data.domain).attr('flag','true');
						}else{
							$(_this).after('@'+username);
							$(_this).remove();
						}
					}
				})
			}			
		})		
	})

}

//检测输入长度
function checkStrLen(obj){
	if($(obj).val().length>0){
			var length=$(obj).val().length;
			var total=280;
			for(var i=0;i<length;i++){
				if($(obj).val().charAt(i).charCodeAt()>255){
					total=total-2;
				}else{
					total=total-1;
				}
			}
			var tmp=total/2
			if(tmp>=0){
				$('.num').html('还可以输入<strong>'+Math.abs(parseInt(tmp))+'</strong>字');
				return true;
			}else{
				$('.num').html('您已经超过了<strong class="red">'+Math.abs(parseInt(tmp))+'</strong>字');
				return false;
			}
		}else{
				$('strong').html(140)
		}
}


//通过URL得到图片的长和高
function imgLoadEvent(callback, url) {//圖片事件加載
	var img = new Image();
	img.onreadystatechange = function () {
		if (this.readyState == "complete") {
			callback({ "w": img.width, "h": img.height });
		}
	}
	img.onload = function () {
	if (this.complete == true)
		callback({ "w": img.width, "h": img.height });
	}
	img.onerror = function () {
		callback({ "w": 0, "h": 0 });
	}
	img.src = url;
}
//图片翻页
function pic(url,sourceUrl){
	imgLoadEvent(function(obj){
		$('#images_zoom').dialog({
			height: obj.h + 60,
		})
		$('#images_zoom img').attr('src', url)
		$('#images_zoom .image_zoom_source').attr('href',sourceUrl)
		var top = $('#images_zoom').dialog('widget').position().top, 
		left = $('#images_zoom').dialog('widget').position().left;
		$('.image_close').css({
			'position': 'fixed',
			'left': left + 570,
			'top': top - 12,
		})
		$('#images_zoom .left,#images_zoom .right').css({
			'top': $('#images_zoom').dialog('option', 'height') / 2 - 35,
			'height': 70,
			'border-radius': 8,
			'border-radius': 8,
			'width': 150,
		})
																			
	},url)
}