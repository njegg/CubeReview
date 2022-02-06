package com.njegg.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import model.ReportReview;

public interface ReportRepo extends JpaRepository<ReportReview, Integer> {

}
