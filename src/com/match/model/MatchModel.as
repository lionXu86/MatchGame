package com.match.model{
	import com.match.signal.CellExchangeSignal;
	import com.match.signal.MatchInitShowSignal;
	import com.match.signal.RemoveSignal;
	
	import flash.geom.Point;

	public class MatchModel{
		
		[Inject]
		public var matchInitShowSignal:MatchInitShowSignal;
		
		[Inject]
		public var cellExchangeSignal:CellExchangeSignal;
		
		[Inject]
		public var removeSignal:RemoveSignal;
		
		private var removePointList:Array;
		
		private var _matchArr:Array;
		
		public function MatchModel()
		{
		}
		
		public function initData():void
		{
			_matchArr = getRandomMatrix();
			matchInitShowSignal.dispatch(_matchArr);
		}
		
		public function exchange(x1:int, y1:int, x2:int, y2:int):void
		{
			//交换
			var temp:int = _matchArr[x1][y1];
			_matchArr[x1][y1] = _matchArr[x2][y2];
			_matchArr[x2][y2] = temp;
			if(checkMatch())
			{
				//复原
				remove();
			}
			else
			{
				temp = _matchArr[x1][y1];
				_matchArr[x1][y1] = _matchArr[x2][y2];
				_matchArr[x2][y2] = temp;
				cellExchangeSignal.dispatch([x1, y1, x2, y2]);
			}
		}
		
		public function checkMatch():Boolean
		{
			removePointList = [];
			//检测列
			for (var i:int = 0; i < Global.MATCH_COL; i++) 
			{
				for (var j:int = 0; j < Global.MATCH_ROW - 2; j++) 
				{
					if (_matchArr[i][j] == _matchArr[i][j + 1] && _matchArr[i][j + 1]== _matchArr[i][j + 2]) //检测连续三个是否相同
					{
						removePointList.push(new Point(i, j), new Point(i, j + 1), new Point(i, j + 2));//坐标存入数组
						if (j + 3 < Global.MATCH_ROW )
						{
							var k:int = j + 3; //判断第四个元素
							while (_matchArr[i][j] == _matchArr[i][k]) 
							{
								removePointList.push(new Point(i, k));
								if (k < Global.MATCH_ROW - 1) k++; 
								if (_matchArr[i][j] != _matchArr[i][k] || k == Global.MATCH_ROW -1)
								{
									if (_matchArr[i][j] == _matchArr[i][k]) removePointList.push(new Point(i, k));
									j = k;//直到不一样 跳出 从第一个不同的位置开始继续判断
									break;
								}
							}
						}
					}
				}
			}
			//检测行
			for (j = 0; j < Global.MATCH_ROW; j++) 
			{
				for (i = 0; i < Global.MATCH_COL - 2; i++) 
				{
					if (_matchArr[i][j] == _matchArr[i + 1][j] && _matchArr[i + 1][j]== _matchArr[i + 2][j]) //检测连续三个是否相同
					{
						removePointList.push(new Point(i, j), new Point(i + 1, j), new Point(i + 2, j));//坐标存入数组
						if (i + 3 < Global.MATCH_COL )
						{
							k = i + 3; //判断第四个元素
							while (_matchArr[i][j] == _matchArr[k][j]) 
							{
								removePointList.push(new Point(k, j));
								if (k < Global.MATCH_COL - 1) k++; 
								if(_matchArr[i][j] != _matchArr[k][j] || k == Global.MATCH_COL -1 )
								{
									if (_matchArr[i][j] == _matchArr[k][j]) removePointList.push(new Point(k, j));
									i = k;//直到不一样 跳出 从第一个不同的位置开始继续判断
									break;
								}
							}
						}
					}
				}
			}
			if(removePointList.length != 0)
				return true;
			else
				return false;
		}
		
		private function remove():void
		{
			var p:Point;
			for(var i:int = 0; i < removePointList.length; i++)
			{
				p = removePointList[i];
				_matchArr[p.x][p.y] = 0;
			}
			
			var tempArr:Array = this.clone2DArray(_matchArr);
			var tempArr2:Array = [];
			
			var num:int;
			var tempRow:int;
			//取消0重新调整数据并生成新的数据
			for(i = 0; i < Global.MATCH_COL; i++)
			{
				num = 0;
				tempRow = -1;
				//计算每列消除的方块个数
				var tempArr3:Array = [];
				tempArr2.push(tempArr3);
				
				var tempArr4:Array = [];
				//移除消除的方块,新增方块
				for(var j:int = 0; j < Global.MATCH_ROW; j++)
				{
					if(_matchArr[i][j] != 0)
					{
						tempArr4.push(_matchArr[i][j]);
					}
					else
					{
						num++;
					}
				}
				var type:int;
				while(num)
				{
					type = Math.floor(Math.random() * Global.MATCH_TYPE + 1);
					tempArr4.push(type);
					tempArr3.push(type);
					num--;
				}
				_matchArr[i] = tempArr4;
			}
			
			traceMatrix();
			removeSignal.dispatch(tempArr, tempArr2);
		}
		
		public function updata():void
		{
			if(checkMatch())
			{
				remove();
			}
		}
		
		private function getRandomMatrix():Array
		{
			var temp:Array = [];
			var temp1:Array;
			for(var i:int = 0; i < Global.MATCH_COL; i++)
			{
				temp1 = [];
				for(var j:int = 0; j < Global.MATCH_ROW; j++)
				{
					temp1.push(Math.floor(Math.random() * Global.MATCH_TYPE + 1));
				}
				trace(temp1);
				temp.push(temp1);
			}
			return temp;
		}
		
		/**
		 * 非深度复制 
		 * 
		 */		
		private function clone2DArray(source:Array):Array
		{
			var temp:Array = [];
			var temp1:Array;
			for(var i:int = 0; i < Global.MATCH_COL; i++)
			{
				temp1 = [];
				for(var j:int = 0; j < Global.MATCH_ROW; j++)
				{
					temp1.push(source[i][j]);
				}
				trace(temp1);
				temp.push(temp1);
			}
			return temp;
		}
		
		private function traceMatrix():void
		{
			trace("--->新矩阵:");
			var temp1:Array;
			for(var i:int = 0; i < Global.MATCH_COL; i++)
			{
				temp1 = _matchArr[i];
				trace(temp1);
			}
		}
	}
}