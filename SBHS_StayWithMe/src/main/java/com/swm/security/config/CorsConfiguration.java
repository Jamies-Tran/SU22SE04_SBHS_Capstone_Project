package com.swm.security.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfiguration {

	@Value("${allowed.origin.staywithme}")
	private String allowedOriginStayWithMe;
	
	@Value("${allowed.origin.momo}")
	private String allowedOriginMomo;
	
	@Bean
	public WebMvcConfigurer corsConfig() {
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/api/**").allowedOrigins(allowedOriginStayWithMe, allowedOriginMomo)
						.allowedMethods("GET", "POST", "PATCH", "DELETE").allowedHeaders("*");
			}

		};
	}

}
