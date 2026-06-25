












  	// (*this) 可省略
	void swapWith(Student& other) 
	{
        // 暫存對方的成績
	    int temp1 = other.chinese;
	    int temp2 = other.english; 
	    int temp3 = other.math;
	    
	    // 把自己的給對方
	    other.chinese = chinese;
	    other.english = english;
	    other.math    = math;
	    
	    // 把暫存的給自己
	    chinese = temp1;
	    english = temp2;
	    math    = temp3;
	}
	





  	










	A.swapWith(B);




	

