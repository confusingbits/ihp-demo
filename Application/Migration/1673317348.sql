CREATE TABLE projects (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    standup_prompt TEXT NOT NULL
);
