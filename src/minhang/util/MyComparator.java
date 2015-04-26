package minhang.util;

import java.util.Comparator;

import minhang.entity.YiweiResult;

public class MyComparator implements Comparator<YiweiResult>{

		
		public int compare(YiweiResult y1, YiweiResult y2) {
			// TODO Auto-generated method stub
			float bfb1=y1.getPercent();
			float bfb2=y2.getPercent();
			if(bfb1<bfb2){
				return 1;
			}else if(bfb1>bfb2){
				return -1;
			}else{
				return 0;
			}
		}
	
}
