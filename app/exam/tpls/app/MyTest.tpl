<div class="container-fluid">
	<div class="row-fluid">
		<div class="main box itembox">
			<div class="col-xs-12 " style="padding-left:0px;">
				{x2;tree:$basics,basic,bid}
					<div class="col-xs-3" style="width:30%">
						<a href="index.php?{x2;$_app}-app-index-setCurrentBasic&basicid={x2;v:basic['basicid']}" class="thumbnail ajax" target="_blank">
							<img src="{x2;if:v:basic['basicthumb']}{x2;v:basic['basicthumb']}{x2;else}app/core/styles/img/item.jpg{x2;endif}" alt="" width="50%">
						</a>
						<h5 class="text-center">{x2;v:basic['basic']}</h5>
					</div>
					{x2;if:v:bid % 6 == 0}
						<div class="col-xs-12"><hr /></div>
					{x2;endif}
				{x2;endtree}
			</div>
		
		</div>
	</div>
</div>


