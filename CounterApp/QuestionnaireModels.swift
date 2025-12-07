import Foundation

// MARK: - Questionnaire Models
struct QuestionnaireData: Codable {
    let questionnaire: Questionnaire
}

struct Questionnaire: Codable {
    let title: String
    let description: String
    let questions: [Question]
}

struct Question: Codable {
    let id: Int
    let question: String
    let type: String
    let followUp: String?
    let keywords: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case type
        case followUp = "follow_up"
        case keywords
    }
}

// MARK: - Respondent Information Models
struct RespondentInfo: Codable {
    let name: String
    let age: Int
    let gender: String
    let phone: String
    let location: String
}

// MARK: - Exported Survey Models
struct ExportedSurvey: Decodable {
    let matchedQuestions: [ExportedMatchedQuestion]
    let respondentInfo: ExportedRespondentInfo?
    
    enum CodingKeys: String, CodingKey {
        case matchedQuestions = "matched_questions"
        case respondentInfo = "respondent_info"
    }
}

struct ExportedMatchedQuestion: Decodable {
    let matchedQuestionId: Int
    let matchedQuestion: String
    let extractedAnswer: String?
    
    enum CodingKeys: String, CodingKey {
        case matchedQuestionId = "matched_question_id"
        case matchedQuestion = "matched_question"
        case extractedAnswer = "extracted_answer"
    }
}

struct ExportedRespondentInfo: Decodable {
    let name: String?
    let age: Int?
    let gender: String?
    let phone: String?
    let location: String?
}

// MARK: - POE API Response Models
struct MatchedQuestion: Codable {
    let matchedQuestionId: Int
    let matchedQuestion: String
    let extractedAnswer: String
    let confidence: String
    let clarificationNeeded: Bool
    
    enum CodingKeys: String, CodingKey {
        case matchedQuestionId = "matched_question_id"
        case matchedQuestion = "matched_question"
        case extractedAnswer = "extracted_answer"
        case confidence
        case clarificationNeeded = "clarification_needed"
    }
}

