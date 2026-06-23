package server

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestStubHealth(t *testing.T) {
	t.Parallel()

	req := httptest.NewRequest(http.MethodGet, "/healthz", nil)
	rec := httptest.NewRecorder()

	handleHealth(rec, req)

	if rec.Code != http.StatusOK {
		t.Fatalf("status = %d, want %d", rec.Code, http.StatusOK)
	}

	body := rec.Body.String()
	if body == "" || body[0] != '{' {
		t.Fatalf("expected JSON body, got %q", body)
	}
}

func TestStubBuildInfo(t *testing.T) {
	t.Parallel()

	req := httptest.NewRequest(http.MethodGet, "/api/v2/buildinfo", nil)
	rec := httptest.NewRecorder()

	handleBuildInfo(rec, req)

	if rec.Code != http.StatusOK {
		t.Fatalf("status = %d, want %d", rec.Code, http.StatusOK)
	}
}
