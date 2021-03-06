<extend name="Base/common" />
<block name="head">
	<link rel="stylesheet" href="__CSS__/index.css">
	<link rel="stylesheet" href="__UPLOADIFY__/uploadify.css">
	<link rel="stylesheet" href="__CSS__/rl_exp.css" />
	<script type="text/javascript" src="__UPLOADIFY__/jquery.uploadify.min.js"></script>		
	<script type="text/javascript" src="__JS__/rl_exp.js"></script>
	<script type="text/javascript" src="__JS__/june_pic.js"></script>
	<script type="text/javascript" src="__JS__/jquery.scrollUp.js"></script>
	<script type="text/javascript" src="__JS__/index.js"></script>	
</block>
<block name="main">
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
		
		<!-- 主题部分 -->
		<div class="weibo_content">
			<ul>
				<li><a href="javascript:void(0)" class="selected">我关注的<i class="nav_arrow"></i></a></li>
				<li><a href="javascript:void(0)">互听的</a></li>
			</ul>
			<volist name="topicList" id="obj">
				<empty name="obj.reid">									
					<dl class="weibo_content_data">
						<dt class="face">
							<empty name="obj.face">
								<empty name="obj.domain">
									<a href="{:U('Space/index',array('id'=>$obj['uid']))}"><img src="__IMG__/small_face.jpg" alt="" ></a>
									<else/>
									<a href="__ROOT__/june/{$obj.domain}"><img src="__IMG__/small_face.jpg" alt="" ></a>
								</empty>
								
							<else/>
								<empty name="obj.domain">
									<a href="{:U('Space/index',array('id'=>$obj['uid']))}"><img src="__ROOT__/{$obj['face']->small}" alt="2" ></a>
									<else/>
									<a href="__ROOT__/june/{$obj.domain}"><img src="__ROOT__/{$obj['face']->small}" alt="2" ></a>
								</empty>							
							</empty>				
						</dt>
						<dd class="content">
							<h4>
								<empty name="obj.domain">
									<a href="{:U('Space/index',array('id'=>$obj['uid']))}">{$obj.username}</a>
									<else/>
									<a href="__ROOT__/june/{$obj.domain}">{$obj.username}</a>
								</empty>	
							</h4>
							<p style="padding:5px 0 0 0">{$obj.content}</p>					
							<switch name="obj.count">
								<case value="0"></case>
								<case value="1">
									<div class="oneImage"><img src="__ROOT__/{$obj['images'][0]['thumb']}" alt="" /></div>
									<div class="image_zoom" style="display:none;">
										<ol>
											<li><a href="javascript:void(0)" class="image_zoom_in">收起</a></li>
											<li ><a target="_blank" class="image_zoom_source" href="__ROOT__/{$obj['images'][0]['source']}">原图</a></li>
										</ol>
										<img source="__ROOT__/{$obj['images'][0]['unfold']}" src="__IMG__/loading_100.png" alt="" />
									</div>
								</case>
								<default/>
										<volist name="obj.images" id="images">									
											<div class="images">
												<img class="show_unfold_pic" src="__ROOT__/{$images['thumb']}" key="{$obj.username}_{$obj.create}" alt="" unfold="__ROOT__/{$images['unfold']}" source="__ROOT__/{$images['source']}" />
											</div>
											<script>
												if(typeof THINKPHP["{$obj.username}_{$obj.create}"] == 'undefined')THINKPHP["{$obj.username}_{$obj.create}"]=[];
												
												if("{$obj['images'][0]['unfold']}" != ''){
													THINKPHP["{$obj.username}_{$obj.create}"].push("__ROOT__/{$images['source']}")
													THINKPHP["{$obj.username}_{$obj.create}"].push("__ROOT__/{$images['unfold']}")												
												}				
											</script>
										</volist>
							</switch>
							<div class="footer">
								<span class="time">{$obj['time']}</span>
								<span class="handler">赞(0) | 
								<a href="javascript:;" class="re">转播</a> 
								| <a href="javascript:;" class="comment">评论</a> 
								| 收藏</span>
								<div class="re_box re_comm_box" style="display:none;">
									<p>250字以内</p>
									<textarea class="re_text re_comm_text" name="commend"></textarea>
									<input type="hidden" name="reid" value="{$obj.id}" />
									<input class="re_button" type="button" value="转播">
								</div>
								<div class="comm_box re_comm_box" style="display:none;">
									<p>250字以内</p>
									<textarea class="comm_text re_comm_text" name="comment"></textarea>
									<input type="hidden" name="tid" value="{$obj.id}" />
									<input class="comm_button" type="button" value="评论">
									<div class="comment_content"></div>
								</div>
							</div>
						</dd>
					</dl>
				<else/>
					
						<dl class="weibo_content_data">
							<dt class="face">
								<empty name="obj.face">
									<empty name="obj.domain">
										<a href="{:U('Space/index',array('id'=>$obj['uid']))}"><img src="__IMG__/small_face.jpg" alt="" ></a>
										<else/>
										<a href="__ROOT__/june/{$obj.domain}"><img src="__IMG__/small_face.jpg" alt="" ></a>
									</empty>
									
								<else/>
									<empty name="obj.domain">
										<a href="{:U('Space/index',array('id'=>$obj['uid']))}"><img src="__ROOT__/{$obj['face']->small}" alt="2" ></a>
										<else/>
										<a href="__ROOT__/june/{$obj.domain}"><img src="__ROOT__/{$obj['face']->small}" alt="2" ></a>
									</empty>							
								</empty>				
							</dt>
							<dd class="content">
								<h4>
									<empty name="obj.domain">
										<a href="{:U('Space/index',array('id'=>$obj['uid']))}">{$obj.username}</a>
										<else/>
										<a href="__ROOT__/june/{$obj.domain}">{$obj.username}</a>
									</empty>	
								</h4>
								<p style="padding:5px 0 0 0">{$obj.content}</p>
								<div class="re_content" style="overflow:auto;">
										<h5>
											<empty name="obj.recontent.domain">
												<a href="{:U('Space/index', array('id'=>$obj['recontent']['uid']))}">@{$obj.recontent.username}</a>
											<else/>
												<a href="__ROOT__/june/{$obj.recontent.domain}">@{$obj.recontent.username}</a>
											</empty>
										</h5>
										<p style="padding:5px 0 0 0">{$obj.recontent.content}</p>		
										<switch name="obj.recontent.count">
											<case value="0"></case>
											<case value="1">
												<div class="oneImage"><img src="__ROOT__/{$obj.recontent['images'][0]['thumb']}" alt="" /></div>
												<div class="image_zoom" style="display:none;">
													<ol>
														<li><a href="javascript:void(0)" class="image_zoom_in">收起</a></li>
														<li ><a target="_blank" class="image_zoom_source" href="__ROOT__/{$obj.recontent['images'][0]['source']}">原图</a></li>
													</ol>
													<img source="__ROOT__/{$obj['images'][0]['unfold']}" src="__IMG__/loading_100.png" alt="" />
												</div>
											</case>
											<default/>
													<volist name="obj.recontent.images" id="images">									
														<div class="images">
															<img class="show_unfold_pic" src="__ROOT__/{$images['thumb']}" key="{$obj.recontent.username}_{$obj.recontent.create}" alt="" unfold="__ROOT__/{$images['unfold']}" source="__ROOT__/{$images['source']}" />
														</div>
														<script>
															if(typeof THINKPHP["{$obj.username}_{$obj.create}"] == 'undefined')THINKPHP["{$obj.username}_{$obj.create}"]=[];
															
															if("{$obj.recontent['images'][0]['unfold']}" != ''){
																THINKPHP["{$obj.recontent.username}_{$obj.recontent.create}"].push("__ROOT__/{$images['source']}")
																THINKPHP["{$obj.recontent.username}_{$obj.recontent.create}"].push("__ROOT__/{$images['unfold']}")												
															}				
														</script>
													</volist>
										</switch>
										<div class="footer">
											<span class="time">{$obj.recontent.time} 该微博共被转播了{$obj.recontent.re_count}次</span>
										</div>
								</div>	
								<div class="footer">
									<span class="time">{$obj['time']}</span>
									<span class="handler">赞(0) | 
									<a href="javascript:;" class="re">转播</a> 
									| <a href="javascript:;" class="comment">评论</a> 
									| 收藏</span>
									<div class="re_box re_comm_box" style="display:none;">
										<p>250字以内</p>
										<textarea class="re_text re_comm_text" name="commend"></textarea>
										<input type="hidden" name="reid" value="{$obj.recontent.id}" />
										<input class="re_button" type="button" value="转播">
									</div>
									<div class="comm_box re_comm_box" style="display:none;">
										<p>250字以内</p>
										<textarea class="comm_text re_comm_text" name="comment"></textarea>
										<input type="hidden" name="tid" value="{$obj.id}" />
										<input class="comm_button" type="button" value="评论">
										<div class="comment_content"></div>
									</div>
								</div>
							</dd>
						</dl>				
				
			</empty>
			</volist>
			<div id="loadmore">加载更多<img src="__IMG__/loadmore.gif" alt="" /></div>
			<div id="images_zoom">				
				<ol>
					<li ><a target="_blank" class="image_zoom_source" href="__ROOT__/{$obj['images'][0]['source']}">原图</a></li>
				</ol>
				<img src="__IMG__/loading_100.png" alt="" />
				<div class="left">上一张</div>
				<div class="right">下一张</div>
			</div>
			
			<img src="__IMG__/close.png" alt="" class="image_close">	
		</div>
		
		<!-- 无图片微博ajax加载 -->
		<div class="ajax_none_pic">	
			<dl class="weibo_content_data">
				<dt class="face">
					<empty name="auth.face">
							<empty name="auth.domain">
								<a href="{:U('Space/index',array('id'=>session('auth')['id']))}"><img src="__IMG__/small_face.jpg" alt="" ></a>
								<else/>
								<a href="__ROOT__/june/{$auth.domain}"><img src="__IMG__/small_face.jpg" alt="" ></a>
							</empty>						
					<else/>
							<empty name="auth.domain">
								<a href="{:U('Space/index',array('id'=>session('auth')['id']))}"><img src="__ROOT__/{$smallFace}" alt="3" ></a>
								<else/>
								<a href="__ROOT__/june/{$auth.domain}"><img src="__ROOT__/{$smallFace}" alt="2" ></a>
							</empty>							
					</empty>
				</dt>
				<dd class="content">
					<h4>
						<empty name="auth.domain">
							<a href="{:U('Space/index',array('id'=>session('auth')['id']))}">{:session('auth')['username']}</a>
							<else/>
							<a href="__ROOT__/june/{:session('auth')['domain']}">{:session('auth')['username']}</a>
						</empty>
					</h4>
					<p>#内容#</p>
					<div class="footer">
						<span class="time">刚刚发布</span>
						<span class="handler">赞(0) | 
							<a href="javascript:;" class="re">转播</a> 
							| <a href="javascript:;" class="comment">评论</a> 
							| 收藏</span>
							<div class="re_box re_comm_box" style="display:none;">
								<p>250字以内</p>
								<textarea class="re_text re_comm_text" name="commend"></textarea>
								<input type="hidden" name="reid" value="{$obj.id}" />
								<input class="re_button" type="button" value="转播">
							</div>
							<div class="comm_box re_comm_box" style="display:none;">
								<p>250字以内</p>
								<textarea class="comm_text re_comm_text" name="comment"></textarea>
								<input type="hidden" name="tid" value="{$obj.id}" />
								<input class="comm_button" type="button" value="评论">
								<div class="comment_content"></div>
							</div>
					</div>
				</dd>
			</dl>
		</div>		
		<!-- 单张图片微博ajax加载 -->
		<div class="ajax_single_pic">
			<dl class="weibo_content_data">
			<dt class="face">
				<empty name="auth.face">
						<empty name="auth.domain">
							<a href="{:U('Space/index',array('id'=>session('auth')['id']))}"><img src="__IMG__/small_face.jpg" alt="" ></a>
							<else/>
							<a href="__ROOT__/june/{$auth.domain}"><img src="__IMG__/small_face.jpg" alt="" ></a>
						</empty>						
				<else/>
						<empty name="auth.domain">
							<a href="{:U('Space/index',array('id'=>session('auth')['id']))}"><img src="__ROOT__/{$smallFace}" alt="2" ></a>
							<else/>
							<a href="__ROOT__/june/{$auth.domain}"><img src="__ROOT__/{$smallFace}" alt="2" ></a>
						</empty>							
				</empty>
			</dt>
			<dd class="content">
				<h4>
					<empty name="auth.domain">
						<a href="{:U('Space/index',array('id'=>session('auth')['id']))}">{:session('auth')['username']}</a>
						<else/>
						<a href="__ROOT__/june/{:session('auth')['domain']}">{:session('auth')['username']}</a>
					</empty>
				</h4>
				<p>#内容#</p>
				<div class="oneImage"><img src="#图片地址#" alt="" /></div>
				<div class="image_zoom" style="display:none;">
					<ol>
						<li><a href="javascript:void(0)" class="image_zoom_in">收起</a></li>
						<li ><a target="_blank" class="image_zoom_source" href="#原图地址#">原图</a></li>
					</ol>
					<img source="#显示地址#" src="__IMG__/loading_100.png" alt="" />
				</div>
				<div class="footer">
					<span class="time">刚刚发布</span>
					<span class="handler">赞(0) | 
							<a href="javascript:;" class="re">转播</a> 
							| <a href="javascript:;" class="comment">评论</a> 
							| 收藏</span>
							<div class="re_box re_comm_box" style="display:none;">
								<p>250字以内</p>
								<textarea class="re_text re_comm_text" name="commend"></textarea>
								<input type="hidden" name="reid" value="{$obj.id}" />
								<input class="re_button" type="button" value="转播">
							</div>
							<div class="comm_box re_comm_box" style="display:none;">
								<p>250字以内</p>
								<textarea class="comm_text re_comm_text" name="comment"></textarea>
								<input type="hidden" name="tid" value="{$obj.id}" />
								<input class="comm_button" type="button" value="评论">
								<div class="comment_content"></div>
							</div>
				</div>
			</dd>
		</dl>
		</div>
		
		<!-- 多张图片微博ajax加载 -->
		<div class="ajax_muti_pic">	
			<dl class="weibo_content_data">
				<dt class="face">
					<empty name="auth.face">
						<empty name="auth.domain">
							<a href="{:U('Space/index',array('id'=>session('auth')['id']))}"><img src="__IMG__/small_face.jpg" alt="" ></a>
							<else/>
							<a href="__ROOT__/june/{$auth.domain}"><img src="__IMG__/small_face.jpg" alt="" ></a>
						</empty>						
					<else/>
							<empty name="auth.domain">
								<a href="{:U('Space/index',array('id'=>session('auth')['id']))}"><img src="__ROOT__/{$smallFace}" alt="2" ></a>
								<else/>
								<a href="__ROOT__/june/{$auth.domain}"><img src="__ROOT__/{$smallFace}" alt="2" ></a>
							</empty>							
					</empty>
				</dt>
				<dd class="content">
					<h4>
						<empty name="auth.domain">
							<a href="{:U('Space/index',array('id'=>session('auth')['id']))}">{:session('auth')['username']}</a>
						<else/>
							<a href="__ROOT__/june/{:session('auth')['domain']}">{:session('auth')['username']}</a>
						</empty>
					</h4>
					<p>#内容#</p>
					<div class="footer">
						<span class="time">刚刚发布</span>
						<span class="handler">赞(0) | 
							<a href="javascript:;" class="re">转播</a> 
							| <a href="javascript:;" class="comment">评论</a> 
							| 收藏</span>
							<div class="re_box re_comm_box" style="display:none;">
								<p>250字以内</p>
								<textarea class="re_text re_comm_text" name="commend"></textarea>
								<input type="hidden" name="reid" value="{$obj.id}" />
								<input class="re_button" type="button" value="转播">
							</div>
							<div class="comm_box re_comm_box" style="display:none;">
								<p>250字以内</p>
								<textarea class="comm_text re_comm_text" name="comment"></textarea>
								<input type="hidden" name="tid" value="{$obj.id}" />
								<input class="comm_button" type="button" value="评论">
								<div class="comment_content"></div>
							</div>
					</div>
				</dd>
			</dl>
		</div>
		<div class="clear">	</div>
	</div>
	<div class="main_right">
		<dl>
			<dt>
				<empty name="bigFace">
						<img src="__IMG__/big.jpg" alt="头像" />
					<else/>
						<img src="__ROOT__/{$bigFace}" alt="头像" />	
				</empty>				
			</dt>
			<dd>{:session('auth')['username']}</dd>
		</dl>
	</div>
</block>

