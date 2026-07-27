# 🏭 Task 10: The School Exam Process (CI/CD Pipeline)

## The Story
Before you're allowed to go to the NEXT class (production), you go through steps, like exams:
1. **Build** — you finish your homework (build the Docker image).
2. **Test** — teacher checks your homework for mistakes (unit + integration tests).
3. **Security Scan** — teacher checks you didn't copy/cheat (vulnerability scan) 🔍.
4. **Push** — your good homework gets stored safely in the school file room (container registry) with your roll number and date (tags: git-sha, latest, version).
5. **Deploy** — first you show it to your class teacher (dev), then the principal (staging) after approval, and finally it goes on the school notice board for everyone (production)!

**Remember forever:** Build → Test → Scan → Push → Deploy — just like: do homework → get it checked → make sure no cheating → file it safely → show it step by step (class → principal → notice board).
