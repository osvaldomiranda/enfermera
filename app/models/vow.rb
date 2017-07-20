class Vow < ActiveRecord::Base
  before_save :vowsigned

  mount_uploader :vowfile, WpfileUploader 

  belongs_to :candidate
  belongs_to :position
  belongs_to :vote
  belongs_to :workplace

  validates :candidate_id, :vote_id, presence: true

  scope :with_vote, -> with_vote { where(vote_id: with_vote) if with_vote.present?}
  scope :with_candidate, -> with_candidate { where(candidate_id: with_candidate) if with_candidate.present?}


  def create_user_vote(user)
  	user_vote = UserVote.new()

  	user_vote.user_id = user.id
  	user_vote.vote_id = self.vote_id
    user_vote.token = self.token

    t = self.created_at.strftime("%Y%d%m%H%M%S")
    xmltopdf417 = "<UserVote>"
    xmltopdf417+="<token>#{self.token}</token>"
    xmltopdf417+="<vote_name>#{self.vote.votacion}</vote_name>"
    xmltopdf417+="<vote_date>#{t}</vote_date>"
    xmltopdf417+="<user>#{user.person.fullname}</user>"
    
    tosign_xml = xmltopdf417
    tosign_xml+="<Signature xmlns=\"http://www.w3.org/2000/09/xmldsig#\">"
    tosign_xml+=  "<SignedInfo>"
    tosign_xml+=   "<CanonicalizationMethod Algorithm=\"http://www.w3.org/TR/2001/REC-xml-c14n-20010315\"/>"
    tosign_xml+=    "<SignatureMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#rsa-sha1\"/>"
    tosign_xml+=     "<Reference URI=\"\">"
    tosign_xml+=      "<Transforms>"
    tosign_xml+=         "<Transform Algorithm=\"http://www.w3.org/2000/09/xmldsig#enveloped-signature\"/>"
    tosign_xml+=      "</Transforms>"
    tosign_xml+=      "<DigestMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#sha1\"/>"
    tosign_xml+=      "<DigestValue/>"
    tosign_xml+=     "</Reference>"
    tosign_xml+=  "</SignedInfo>"
    tosign_xml+=  "<SignatureValue/>"
    tosign_xml+=  "<KeyInfo>"
    tosign_xml+=   "<KeyValue/>"
    tosign_xml+=   "<X509Data>"
    tosign_xml+=    "<X509SubjectName/>"
    tosign_xml+=    "<X509IssuerSerial/>"
    tosign_xml+=    "<X509Certificate/>"
    tosign_xml+=   "</X509Data>"
    tosign_xml+=  "</KeyInfo>"
    tosign_xml+= "</Signature>"
    tosign_xml+="</UserVote>"

    File.open("tosign_xml#{self.token}.xml", 'w') { |file| file.puts tosign_xml}
    sleep 1
    system("./comando tosign_xml#{self.token}.xml doc-signed#{self.token}.xml")
    doc = File.open "doc-signed#{self.token}.xml"

    user_vote.xmlfile = doc
    user_vote.save
    system("rm tosign_xml#{self.token}.xml") 
    system("rm doc-signed#{self.token}.xml")
  end

  def vowsigned

    self.generate_token
    
    t = Time.now.strftime("%Y%d%m%H%M%S")

    tosign_xml="<vow>"
    tosign_xml+="<token>#{self.token}</token>"
    tosign_xml+="<vote_name>#{self.vote.votacion}</vote_name>"
    tosign_xml+="<vote_date>#{t}</vote_date>"
    tosign_xml+="<choice>#{self.candidate.candidato}</choice>"
    tosign_xml+="<candidate_id>#{self.candidate_id}</candidate_id>"
    tosign_xml+="<Signature xmlns=\"http://www.w3.org/2000/09/xmldsig#\">"
    tosign_xml+=  "<SignedInfo>"
    tosign_xml+=   "<CanonicalizationMethod Algorithm=\"http://www.w3.org/TR/2001/REC-xml-c14n-20010315\"/>"
    tosign_xml+=    "<SignatureMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#rsa-sha1\"/>"
    tosign_xml+=     "<Reference URI=\"\">"
    tosign_xml+=      "<Transforms>"
    tosign_xml+=         "<Transform Algorithm=\"http://www.w3.org/2000/09/xmldsig#enveloped-signature\"/>"
    tosign_xml+=      "</Transforms>"
    tosign_xml+=      "<DigestMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#sha1\"/>"
    tosign_xml+=      "<DigestValue/>"
    tosign_xml+=     "</Reference>"
    tosign_xml+=  "</SignedInfo>"
    tosign_xml+=  "<SignatureValue/>"
    tosign_xml+=  "<KeyInfo>"
    tosign_xml+=   "<KeyValue/>"
    tosign_xml+=   "<X509Data>"
    tosign_xml+=    "<X509SubjectName/>"
    tosign_xml+=    "<X509IssuerSerial/>"
    tosign_xml+=    "<X509Certificate/>"
    tosign_xml+=   "</X509Data>"
    tosign_xml+=  "</KeyInfo>"
    tosign_xml+= "</Signature>"
    tosign_xml+="</vow>"

    
    File.open("tosign_xml#{t}.xml", 'w') { |file| file.puts tosign_xml}
    sleep 1
    system("./comando tosign_xml#{t}.xml doc-signed#{t}.xml")
    doc = File.open "doc-signed#{t}.xml"

    self.vowfile = doc

    system("rm tosign_xml#{t}.xml") 
    system("rm doc-signed#{t}.xml")

  end

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Vow.exists?(token: random_token)
    end
  end
end
