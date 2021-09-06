<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"  />

	<xsl:template match="/QuizDTO">
		<html>
			<head>
				<style>
					body {
						font-family: arial;
						background-color: #E7F3FF;
					}

					p {
						margin: 7px;
					}

					span.score{
						font-weight: bold;
					}

					div.question {
						padding: 10px;
						background-color: white;
						margin-bottom: 7px;
						max-width: 700px;
					}

					div.questionHeader {
						background-color: #DDDDDD;
						border: solid silver 1px;
						border-radius: 5px;
						text-align: left;
						padding-left: 7px;
					}
					div.questionHeader h3 {
						margin: 10px;
					}

					div.answer {
						padding: 2px;
						border-radius: 4px;
						margin-top:4px;
					}
					div.incorrectAnswer {
						background-color: #FFB3B3;
					}
					div.correctAnswer {
						background-color: #C0F85D;
					}
					div.answer span:nth-child(2){
						padding-left: 7px;
						font-weight: bold;
					}
					div.answer span:nth-child(1) {
						padding-left: 4px !important;
					}

					div.completedDate {
						font-size: smaller;
						margin-top: 10px;
					}
				</style>
			</head>
			<body>
				<div class="quiz">
					<h2>Highway Quiz - Completed</h2>
					<div>
						<p>Thank you <span class="firstname"><xsl:value-of select="concat(User/FirstName, ' ', User/LastName)"/></span> for completing the quiz!</p>
						<p>Your score: <span class="score"><xsl:value-of select="Score"/></span></p>
						<p>Your grade: <span class="score"><xsl:value-of select="Grade"/></span></p>
					</div>
					<div>
						<xsl:apply-templates select="Details/QuizDetail" />
						<div class="completedDate">
							Quiz completed: <xsl:value-of select="DateCompleted"/>
						</div>
					</div>
				</div>
			</body>
		</html>
		
	</xsl:template>

	<xsl:template match="QuizDetail">
		<div class="question">
			<div class="questionHeader">
				<h3>Question: <xsl:value-of select="QuestionNumber"/></h3>
				<span><xsl:value-of select="OrigQuestionDescr"/></span>
			</div>		
			<xsl:choose>
				<xsl:when test="SelectedAnswerId = CorrectAnswerId">
					<div class="answer correctAnswer">
						<span>Correct!</span>
						<span>
							<xsl:value-of select="SelectedAnswerDescr"/>
						</span>
					</div>
				</xsl:when>
				<xsl:otherwise>
					<div class="answer incorrectAnswer">
						<span>Your Answer:</span>
						<span><xsl:value-of select="SelectedAnswerDescr"/></span>
					</div>
					<div class="answer">
						<span>Correct Answer:</span>
						<span><xsl:value-of select="CorrectAnswerDescr"/></span>
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</div>	
	</xsl:template>

</xsl:stylesheet>