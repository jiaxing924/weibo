<extend name="Base/common" />
<block name="main">
	<script>
		var	THINKPHP={
			'img': '__IMG__',
			'module':'__MODULE__',
			'uploadify':'__UPLOADIFY__',
			'uploader':'{:U("File/upload")}',
			'root':'__ROOT__',
		}
	</script>
	<div class="main_left">
		<form class="weibo_form">
			<span class="left">和大家一起分享点新鲜事吧</span>
			<span class="right num">还可以输入<strong>140</strong>字</span>
			<textarea class="text" name="content" id="rl_exp_input"></textarea>
			<a href="javascript:void(0);" id="rl_exp_btn" class="face">表情<span class="face_arrow_top"></span></a>
			<div class="rl_exp" id="rl_bq" style="display:none;">
				<ul class="rl_exp_tab clearfix">
					<li><a href="javascript:void(0);" class="selected">默认</a></li>
					<li><a href="javascript:void(0);">拜年</a></li>
					<li><a href="javascript:void(0);">浪小花</a></li>
					<li><a href="javascript:void(0);">暴走漫画</a></li>
				</ul>
				<ul class="rl_exp_main clearfix rl_selected"></ul>
				<ul class="rl_exp_main clearfix" style="display:none;"></ul>
				<ul class="rl_exp_main clearfix" style="display:none;"></ul>
				<ul class="rl_exp_main clearfix" style="display:none;"></ul>
				<a href="javascript:void(0);" class="close">×</a>
			</div>
			<a href="javascript:void(0);" class="pic" id="pic_btn">图片<span class="pic_arrow_top"></span></a>
			<div class="weibo_pic_box" id="pic_box">
				<div class="weibo_pic_header">
					<span class="weibo_pic_ino">共 <span class="uploadTotal"></span> 张，还能上传 <span class="uploadLimit"></span> 张（按住ctrl键可选择多张）</span>
					<a href="javascript:void(0);" class="close">×</a>				
				</div>
				<div class="weibo_pic_list">
				</div>
				<input type="file" name="file" id="file"/>
			</div>
			<input type="button" value="发布" class="button" />
		</form>
		
		
		<div class="weibo_content">
			<ul>
				<li><a href="javascript:void(0)" class="selected">我关注的<i class="nav_arrow"></i></a></li>
				<li><a href="javascript:void(0)">互听的</a></li>
			</ul>
			<volist name="topicList" id="obj">
			<dl class="weibo_content_data">
				<dt class="face"><a href="javascript:void(0)"><img src="__IMG__/small_face.jpg" alt="" ></a></dt>
				<dd class="content">
					<h4><a href="javascript:void(0)">{$obj.username}</a></h4>
					<p>{$obj.content}{$obj.content_over}</p>					
					<switch name="obj.count">
						<case value="0"></case>
						<case value="1"><div class="oneImage"><img src="__ROOT__/{$obj['images'][0]['thumb']}" alt="" /></div></case>
						<default/>
								<volist name="obj.images" id="images">									
									<div class="images">
										<img src="__ROOT__/{$images['thumb']}" alt="" />
									</div>
								</volist>
					</switch>
					<div class="footer">
						<span class="time">8月25日 08:35</span>
						<span class="handler">赞(0) | 转播 | 评论 | 收藏</span>
					</div>
				</dd>
			</dl>
			</volist>
			
		</div>
	</div>
	<div class="main_right">right</div>
</block>

