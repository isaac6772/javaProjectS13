package com.spring.javaProjectS13.common;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ScheduledFuture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.spring.javaProjectS13.service.DiscussionService;
import com.spring.javaProjectS13.vo.DiscussionVO;

@Component
public class DynamicScheduler {
	
	@Autowired
	DiscussionService discussionService;
	
    private final TaskScheduler taskScheduler;
    private final Map<Integer, ScheduledFuture<?>> scheduledTasks = new ConcurrentHashMap<>();

    public DynamicScheduler(TaskScheduler taskScheduler) {
        this.taskScheduler = taskScheduler;
    }

    public void scheduleTask(int memberIdx, int discussionIdx, WebSocketSession session) {
    	DiscussionVO dVo = discussionService.discussion(discussionIdx);
    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
    	LocalDateTime discussionDate = LocalDateTime.parse(dVo.getDiscussionDate(),formatter);
    	
        Runnable task = () -> {
            try {
            	if(session.isOpen()) {
            		Duration duration = Duration.between(LocalDateTime.now(), discussionDate);	// 토론시간과 현재시간을 비교
            		
            		if(duration.toSeconds() > 0 && duration.toSeconds() <= 1800) {	// 입장시간일때
            			session.sendMessage(new TextMessage("{\"msgType\":\"time\",\"data\":\"" +duration.toSeconds()+"\",\"option\":\"before\"}"));
            		}
            		else if(duration.toSeconds() == 0) {	// 토론시간
            			session.sendMessage(new TextMessage("{\"msgType\":\"time\",\"data\":\"" +duration.toSeconds()+"\",\"option\":\"start\"}"));
            		}
            		else if(duration.toSeconds() < 0 && duration.toSeconds() > -(dVo.getDiscussionTime()*60)) {		// 토론시작 후 종료전
            			session.sendMessage(new TextMessage("{\"msgType\":\"time\",\"data\":\"" + (dVo.getDiscussionTime()*60 + duration.toSeconds())+"\",\"option\":\"going\"}"));
            		}
            		else if(duration.toSeconds() <= -(dVo.getDiscussionTime()*60)) {		// 토론 종료
            			session.sendMessage(new TextMessage("{\"msgType\":\"time\",\"data\":\"end\",\"option\":\"end\"}"));
            			cancelScheduledTask(memberIdx);
            		}
            	}
			} catch (IOException e) {
				e.printStackTrace();
			}
        };

        ScheduledFuture<?> scheduledFuture = taskScheduler.scheduleAtFixedRate(task, 1000);
        scheduledTasks.put(memberIdx, scheduledFuture);
    }

    public void cancelScheduledTask(int memberIdx) {
        // 동적으로 생성된 스케줄을 해제하기 위해 ScheduledFuture를 사용하여 취소
    	ScheduledFuture<?> scheduledFuture = scheduledTasks.get(memberIdx);
    	
        if (scheduledFuture != null && !scheduledFuture.isCancelled()) {
        	scheduledFuture.cancel(true);
        }
    }
}
