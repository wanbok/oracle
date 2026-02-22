# oracle

[Claude Code](https://claude.com/claude-code)를 위한 크로스 모델 검증 도구. Claude와 [Codex (GPT-5.3)](https://github.com/openai/codex)를 연결하여 코드 리뷰, 대안 구현, 아키텍처 검증에 대한 세컨드 오피니언을 받습니다.

[English](README.md)

## 왜 필요한가?

AI 모델마다 강점과 맹점이 다릅니다. 두 번째 모델에게 코드를 리뷰받으면, 한 모델이 놓칠 수 있는 문제를 잡아낼 수 있습니다. Oracle은 이 크로스 검증 워크플로우를 자동화합니다.

## 사전 준비

- [Claude Code](https://claude.com/claude-code) 설치
- [Codex CLI](https://github.com/openai/codex) 설치 + OpenAI API 키 설정

```bash
npm install -g @openai/codex
```

## 설치

```bash
git clone https://github.com/wanbok/oracle.git
cd oracle
chmod +x install.sh
./install.sh
```

`~/.claude/agents/` 디렉토리에 에이전트를 심링크로 설치합니다.

## 사용법

### 커스텀 에이전트로 사용

Task 도구에서 `oracle`을 `subagent_type`으로 지정:

```
Task(subagent_type="oracle", prompt="이 코드의 보안 이슈를 검토해줘: ...")
```

### 팀 역할로 사용

에이전트 팀에 `oracle` 역할을 추가하여 개발 중 지속적인 크로스 모델 검증을 수행합니다. [examples/team-usage.md](examples/team-usage.md) 참고.

## 동작 방식

```
질문 입력
   │
   ▼
Oracle이 관련 코드를
읽음 (Read/Grep)
   │
   ▼
인라인 코드 컨텍스트로
프롬프트 구성
   │
   ▼
Codex CLI로 전송
(타임아웃: 180초)
   │
   ▼
Codex 응답을
품질 검증
   │
   ▼
검증된 결과를
보고
```

Oracle은 **읽기 전용**입니다 — 파일을 수정하지 않습니다. 제안만 하고, 적용은 사용자가 결정합니다.

## 백엔드 설정

기본값은 [Codex CLI](https://github.com/openai/codex)이지만, `agents/oracle.md`의 `codex exec` 명령을 수정하여 다른 백엔드로 교체할 수 있습니다.

| 백엔드 | 명령어 | 비고 |
|--------|--------|------|
| **Codex CLI** (기본) | `codex exec "prompt"` | OpenAI API 키 필요 |
| **Ollama** | `ollama run llama3 "prompt"` | 로컬 실행, 무료, API 키 불필요 |
| **OpenRouter** | `curl`로 OpenRouter API 호출 | 다중 모델 접근, 종량제 |
| **Google Gemini** | `gemini "prompt"` | Google AI API 키 필요 |

백엔드를 변경하려면 `agents/oracle.md`의 "How to Call Codex" 섹션에서 `codex exec` 패턴을 교체하세요.

## 제거

```bash
./uninstall.sh
```

## 라이선스

MIT
