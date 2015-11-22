class StackparsingController < ApplicationController
    def stacklionquestion
        
        
        @questionTitleArr = Array.new #질문의 제목을 담는 배열
        @questionUrlArr = Array.new #질문의 주소를 담는 배열
        @nowpage = params[:fpage]; #현재페이지를 파라미터로 받아옴
        if(@nowpage == nil || @nowpage == "" || @nowpage.to_i < 1 ) #현재페이지각 null or 1 or 1보다 작으면 1로세팅
            @nowpage=1
        end
        
        if @nowpage == nil #만약 현재페이지가 null이면
            @startNum = 3 #스택라이온 사이트 글번호가 3번부터 시작
            @totalNum = 23 #20 개의 질문을 조사
        else
            @startNum = 4  + (@nowpage.to_i-1)*20 #다음 20개의 질문을 조사(시작번호)
            @totalNum = 24 + (@nowpage.to_i-1)*20 #다음 20개의 질문을 조사 (끝번호))
        end
    
        @startNum.upto(@totalNum) do |x| #질문들을 조사하는 반복문 
            uri = URI("http://stack.likelion.net/questions/detail/#{x}") #질문글들의 주소
            html_doc = Nokogiri::HTML(Net::HTTP.get(uri))
            
            
            #답변을 채택한 질문인지 아닌지 체크
            @Adopt = html_doc.css("div.AnswerAcceptControl//i").size #답변을 채택한 글들은 
                                                                     #체크표시 그림이 있습니다
                                                                     #그러한 그림들이 있는지 확인
                                                                     # 즉 #<i class="fa fa-check-circle _accepted"></i>
                                                                     # 이 있는지 없는지 검사
            if (@Adopt != 0) #그림이 있으면
                @result = html_doc.css("h1._QuestionHeader").inner_text #질문들의 제목을 저장
                @questionUrlArr.push(uri) #질문의 url을 배열에 삽입
                @questionTitleArr.push(@result) #질문들의 제목을 배열에삽임
            end

        
        end #end of loop
        
        
    end #end of def stacklionquestion 
end #end of class




