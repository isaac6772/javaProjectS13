package com.spring.javaProjectS13.common;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class MyScheduler {
	
	@Scheduled(cron = "${scheduler.cronExpression}")
	public void scheduleRun() {
		System.out.println("1초마다 실행중");
	}
}
