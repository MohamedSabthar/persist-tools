DROP TABLE IF EXISTS MedicalNeeds;
CREATE TABLE MedicalNeeds (
	fooNeedId INT NOT NULL AUTO_INCREMENT,
	fooItemId INT NOT NULL,
	fooBeneficiaryId INT NOT NULL,
	period VARCHAR(191) NOT NULL,
	urgency INT NOT NULL,
	foo INT NOT NULL,
	PRIMARY KEY(fooNeedId)
);