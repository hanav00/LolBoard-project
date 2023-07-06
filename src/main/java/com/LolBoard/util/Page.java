package com.LolBoard.util;

public class Page {

	public String getPageList(int pageNum, int postNum, int pageListCount, int totalCount, String keyword) {
		
		//pageNum: 현재 페이지 번호
		//postNum: 현 화면에 보여지는 게시물 행 개수 (15)
		//pageListCount: 하단 페이지 리스트에 나타나는 페이지 개수 (5)
		//totalCount: 전체 행 개수
		//totalPage: 현재 페이지 개수
		//section: 한 개의 페이지 목록 (1 2 3 4 5 ->section 1 / 6 7 8 9 10 -> section 2)
		//totalSection: 전체 section 개수
		
		int totalPage = (int)Math.ceil(totalCount / (double)postNum);
		int totalSection = (int)Math.ceil(totalPage / (double)pageListCount);
		int section = (int)Math.ceil((pageNum /(double)pageListCount));

		String pageList = "";
		
		if (totalPage != 1) {
			
			for (int i=1; i<=pageListCount; i++) {
				//◀ 출력 조건: section 값이 1보다 커야하고, i=1인 경우에만 출력(◀ 1 2 3 .. / ◀ 6 7 8 ..)
				if (section>1 && i == 1)
					pageList += "<a href=list?page=" + Integer.toString((section-2)*pageListCount + pageListCount) + "&keyword=" + keyword + ">◀  &nbsp;</a>";
				
				//페이지 출력 중단 조건 (12페이지까지 있으면 ◀ 11 12 하고 끝나야함)
				if (totalPage < (section-1)*pageListCount + i) break;
				
				//인자로 가져온 페이지값과 계산해서 나온 페이지값이 같으면 링크를 붙이지 않고 다른 페이지로 이돟할 수 있는 링크를 붙임
				if(pageNum != (section-1)*pageListCount + i) //(3페이지면, ◀ 1 2 3 4 5 ▶ 에서  1 2 4 5는 이동할 수 있는 링크로 선택 가능해야함)
					pageList += "&nbsp;&nbsp; <a href=list?page=" + Integer.toString((section-1)*pageListCount+i) + "&keyword=" + keyword + ">" + Integer.toString((section-1)*pageListCount+i) +  "</a>";
				else //(3페이지면, ◀ 1 2 3 4 5 ▶ 에서 3은 선택가능하면 안되고, 숫자만 두껍게 나오도록 설정)
					pageList += "&nbsp;&nbsp; <span style='font-weight: bold'>" + Integer.toString((section-1)*pageListCount+i) + "</span>";
				
				//▶ 출력 조건: i==pageListCount만큼 페이지 번호를 출력했을 때 totalSection값이 1보다 커야하고, 아직까지 출력할 페이지가 남아있어야 표시됨
				if (i==pageListCount && totalSection>1 && totalPage>=(i+(section-1)*pageListCount+1))
					pageList += "&nbsp;&nbsp; <a href=list?page=" + Integer.toString(section*pageListCount+1) +"&keyword=" + keyword +">&nbsp;  ▶</a>";
			}
		}
		
		
		
	/*	
		
	//인터넷에 많이 나오는 로직
		
		//pageList의 마지막 번호
		int endPageNum = (int)(Math.ceil(pageNum/(double)pageListCount)*pageListCount);
		
		//pageList의 시작 번호
		int startPageNum = endPageNum - (pageListCount - 1);
		
		//실제 마지막 페이지 번호
		int realEndPageNum = (int)(Math.ceil(totalCount/(double)postNum));
		if (endPageNum > realEndPageNum)
			endPageNum = realEndPageNum;
		
		boolean prev = startPageNum == 1?false:true;
		boolean next = endPageNum * pageListCount >= totalCount?false:true;
		
		String pageList = "";
		
		//이전 버튼 출력 조건
		if(prev)
			pageList += " <a href=list?page=" + Integer.toString(startPageNum-1) + "> ▶</a>";
		for(int i=startPageNum; i<=endPageNum; i++) {
			if(pageNum != i)
				pageList += " <a href=list?page=" + Integer.toString(i) + "></a>";
			if(pageNum == i)
				pageList += " <span style='font-weight: bold'>" + Integer.toString(i) + "</span>";
				
		}
		
		//다음 버튼 출력 조건
		if(next)
			pageList += " <a href=list?page=" + Integer.toString(endPageNum+1) + ">◀ </a>";
		
		*/
		
		
		return pageList;
	}
}
