using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
//using System.En
using System.Data.Entity;
using System.Configuration;
using System.Security.Cryptography;
using IYFD.Models;

namespace IYFD.Utility
{
    public class IYFDData
    {
        private MD5CryptoServiceProvider _cryptographer = new MD5CryptoServiceProvider();

        #region User
        public int? LoginUser(User user)
        {
            int userId; 
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.LogonUser", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@username", user.Username);
                    cmd.Parameters.AddWithValue("@password", Encrypt(user.Password));

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (int.TryParse(reader["ID"].ToString(), out userId))
                                return userId;
                        }
                    }
                }
            }
            return null;
        }

        public bool CheckUser(int userID, Content content)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.CheckUser", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@userID", userID);
                    cmd.Parameters.AddWithValue("@contentID", (int)content);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                            return true;
                        else
                            return false;
                    }
                }
            }
            return false;
        }

        public int? UpsertUser(User user)
        {
            int userId;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.UpsertUser", connection))
                {
                    if (user.ID.HasValue && user.ID.Value > 0)
                        cmd.Parameters.AddWithValue("@ID", user.ID.Value);

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@username", user.Username);
                    cmd.Parameters.AddWithValue("@firstname", user.FirstName);
                    cmd.Parameters.AddWithValue("@lastname", user.LastName);
                    if(!string.IsNullOrEmpty(user.Password))
                        cmd.Parameters.AddWithValue("@password", Encrypt(user.Password));
                    cmd.Parameters.AddWithValue("@email", user.Email);
                    cmd.Parameters.AddWithValue("@active", user.Active);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (int.TryParse(reader["ID"].ToString(), out userId))
                                return userId;
                        }
                    }
                }
            }
            return null;        
        }

        public User GetCurrentUser(int? userID)
        {
            if (userID.HasValue)
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
                {
                    connection.Open();
                    using (SqlCommand cmd = new SqlCommand("dbo.GetUserById", connection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@userID", userID);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                                return new User
                                {
                                    Username = reader["username"].ToString(),
                                    Email = reader["email"].ToString(),
                                    FirstName = reader["firstname"].ToString(),
                                    LastName = reader["lastname"].ToString()
                                };
                        }
                    }
                }
            }
            return null;
        }

        public bool CheckUsername(string username)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.CheckUserByName", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@username", username);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                            return Convert.ToBoolean(reader[0]);
                    }
                }
            }
            return false;
        }
        #endregion

        #region User Tourny
        public List<Tuple<string, int>> GetCurrentLeaders()
        {
            List<Tuple<string, int>> currentLeaders = new List<Tuple<string, int>>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetLeaderBoard", connection))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentLeaders.Add(new Tuple<string, int>(reader["username"].ToString(), Convert.ToInt32(reader["points"])));
                        }
                    }
                }
            }
            return currentLeaders;
        }

        public List<UserChoice> GetCurrentBracket(int? userId, int regionId, int roundId)
        {
            List<UserChoice> currentBracket = new List<UserChoice>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetUserBracket", connection))
                {
                    if (userId.HasValue)
                        cmd.Parameters.AddWithValue("@userID", userId);
                    cmd.Parameters.AddWithValue("@regionId", regionId);
                    cmd.Parameters.AddWithValue("@roundId", roundId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentBracket.Add(new UserChoice
                            {
                                MatchUp = new MatchUp
                                {
                                    Tourny1 = new Tourny
                                    {
                                        Id = (int)reader["tourny1Id"],
                                        Team = new Team { Name = reader["team1"].ToString() },
                                        Rank = (int)reader["rank1"]
                                    },
                                    Tourny2 = new Tourny
                                    {
                                        Id = (int)reader["tourny2Id"],
                                        Team = new Team { Name = reader["team2"].ToString() },
                                        Rank = (int)reader["rank2"]
                                    },
                                    Winner = new Tourny
                                    {
                                        Id = (int)reader["winnderId"],
                                        Team = new Team { Name = reader["winner"].ToString() }
                                    },
                                },
                                Choice = new Tourny
                                {
                                    Id = (int)reader["userChoiceId"],
                                    Team = new Team { ID = Convert.ToInt32(reader["userTeamID"]), Name = reader["userTeam"].ToString() }
                                }
                            });
                        }
                    }
                }
                return currentBracket;
            }
        }

        public List<Tuple<int, string>> GetCurrentScore(int userId)
        {
            List<Tuple<int, string>> currentScore = new List<Tuple<int, string>>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetUserScore", connection))
                {
                    cmd.Parameters.AddWithValue("@userID", userId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentScore.Add(new Tuple<int, string>(Convert.ToInt32(reader["points"]), reader["username"].ToString()));
                        }
                    }
                }
                return currentScore;
            }
        }

        public bool SetUserChoices(List<int> choices, int roundId, int userId)
        {
            foreach (int choiceId in choices)
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
                {
                    connection.Open();
                    using (SqlCommand cmd = new SqlCommand("dbo.SubmitUserChoice", connection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@userId", userId);
                        cmd.Parameters.AddWithValue("@roundId", roundId);
                        cmd.Parameters.AddWithValue("@tournyId", choiceId);

                        cmd.ExecuteNonQuery();
                    }
                }
            }
            return true;
        }

        public List<MatchUp> GetMatchupsForUserByRound(int roundId, int userId)
        {
            List<MatchUp> currentMatchup = new List<MatchUp>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetUserChoiceMatchupsByRound", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@roundId", roundId);
                    cmd.Parameters.AddWithValue("@userId", userId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentMatchup.Add(new MatchUp
                            {
                                ID = Convert.ToInt32(reader["id"]),
                                Tourny1 = new Tourny
                                {
                                    Id = Convert.ToInt32(reader["tourny1id"]),
                                    Team = new Team
                                    {
                                        ID = Convert.ToInt32(reader["team1id"]),
                                        Name = reader["team1name"].ToString()
                                    },
                                    Region = new Region
                                    {
                                        ID = Convert.ToInt32(reader["region1id"]),
                                        Name = reader["region1"].ToString()
                                    },
                                    Rank = Convert.ToInt32(reader["rank1Id"])
                                },
                                Tourny2 = new Tourny
                                {
                                    Id = Convert.ToInt32(reader["tourny2id"]),
                                    Team = new Team
                                    {
                                        ID = Convert.ToInt32(reader["team2id"]),
                                        Name = reader["team2name"].ToString()
                                    },
                                    Region = new Region
                                    {
                                        ID = Convert.ToInt32(reader["region2id"]),
                                        Name = reader["region2"].ToString()
                                    },
                                    Rank = Convert.ToInt32(reader["rank2Id"])
                                },
                                Winner = new Tourny
                                {
                                    Id = GetIntFromDb(reader["winnerId"]),
                                    Team = new Team
                                    {
                                        ID = GetIntFromDb(reader["winnerTeamId"]),
                                        Name = GetStringFromDb(reader["winnerName"])
                                    },
                                    Rank = GetIntFromDb(reader["rankWinnerId"])
                                },
                                roundId = GetIntFromDb(reader["roundId"]),
                                UserChoiceId = GetIntFromDb(reader["userChoice"])
                            });
                        }
                    }
                }
            }
            return currentMatchup;
        }

        #endregion

        #region Admin Tourny

        public List<Team> GetCurrentTeams()
        {
            List<Team> currentTeams = new List<Team>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetCurrentTeams", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentTeams.Add(new Team
                            {
                                Name = reader["name"].ToString(),
                                ID = Convert.ToInt32(reader["ID"]),
                            });
                        }
                    }
                }
            }
            return currentTeams;
        }

        public List<Region> GetAllRegions()
        {
            List<Region> currentRegions = new List<Region>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetAllRegions", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentRegions.Add(new Region
                            {
                                Name = reader["region"].ToString(),
                                ID = Convert.ToInt32(reader["ID"]),
                            });
                        }
                    }
                }
            }
            return currentRegions;
        }

        public List<Round> GetAllRounds()
        {
            List<Round> currentRounds = new List<Round>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetAllRounds", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentRounds.Add(new Round
                            {
                                Name = Convert.ToInt32(reader["roundNo"]),
                                ID = Convert.ToInt32(reader["ID"]),
                            });
                        }
                    }
                }
            }
            return currentRounds;
        }

        public List<Round> GetAllRoundsNoInMatchUp()
        {
            List<Round> currentRounds = new List<Round>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetAllRoundsNotInMatchup", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentRounds.Add(new Round
                            {
                                Name = Convert.ToInt32(reader["roundNo"]),
                                ID = Convert.ToInt32(reader["ID"]),
                            });
                        }
                    }
                }
            }
            return currentRounds;
        }

        public List<Round> GetCurrentRounds()
        {
            List<Round> currentRounds = new List<Round>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetCurrentRounds", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentRounds.Add(new Round
                            {
                                Name = Convert.ToInt32(reader["roundNo"]),
                                ID = Convert.ToInt32(reader["roundId"]),
                            });
                        }
                    }
                }
            }
            return currentRounds;
        }

        public List<Rank> GetAllRanks()
        {
            List<Rank> currentRanks = new List<Rank>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetAllRanks", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentRanks.Add(new Rank
                            {
                                Name = Convert.ToInt32(reader["rank"]),
                                ID = Convert.ToInt32(reader["ID"]),
                            });
                        }
                    }
                }
            }
            return currentRanks;
        }

        public List<Tourny> GetAllTournies()
        {
            List<Tourny> currentTourny = new List<Tourny>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetAllTournies", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentTourny.Add(new Tourny
                            {
                                Rank = Convert.ToInt32(reader["rank"]),
                                Team = new Team
                                {
                                    ID = Convert.ToInt32(reader["teamId"]),
                                    Name = reader["team"].ToString()
                                },
                                Region = new Region
                                {
                                    ID = Convert.ToInt32(reader["regionId"]),
                                    Name = reader["region"].ToString()
                                },
                                Id = Convert.ToInt32(reader["tournyId"])
                            });
                        }
                    }
                }
            }
            return currentTourny;
        }

        public List<IYFD.Models.User> GetAllUsers()
        {
            List<User> users = new List<User>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetAllUsers", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            users.Add(new User
                            {
                                Username = GetStringFromDb(reader["username"]),
                                ID = GetIntFromDb(reader["id"]),
                                FirstName = GetStringFromDb(reader["firstname"]),
                                LastName = GetStringFromDb(reader["lastname"]),
                                Active = Convert.ToBoolean(reader["active"])
                            });
                        }
                    }
                }
            }
            return users;
        }

        public List<IYFD.Models.Role> GetAllRoles()
        {
            List<IYFD.Models.Role> roles = new List<Role>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetAllRoles", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            roles.Add(new Role
                            {
                                Name = GetStringFromDb(reader["role"]),
                                ID = GetIntFromDb(reader["id"]),
                            });
                        }
                    }
                }
            }
            return roles;
        }

        public List<KeyValuePair<int, string>> GetAllContent(int? roleId)
        {
            List<KeyValuePair<int, string>> content = new List<KeyValuePair<int, string>>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetAllContent", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (roleId.HasValue)
                        cmd.Parameters.AddWithValue("@roleId", roleId.Value);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            content.Add(new KeyValuePair<int, string>(GetIntFromDb(reader["id"]),GetStringFromDb(reader["content"])));
                        }
                    }
                }
            }
            return content;
        }

        public List<MatchUp> GetAllMatchups(string roundId)
        {
            int rId;
            List<MatchUp> currentMatchup = new List<MatchUp>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetAllMatchups", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (int.TryParse(roundId, out rId))
                        cmd.Parameters.AddWithValue("@roundId", rId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentMatchup.Add(new MatchUp
                            {
                                ID = Convert.ToInt32(reader["id"]),
                                Tourny1 = new Tourny
                                {
                                    Id = Convert.ToInt32(reader["tourny1id"]),
                                    Team = new Team
                                    {
                                        ID = Convert.ToInt32(reader["team1id"]),
                                        Name = reader["team1name"].ToString()
                                    },
                                    Region = new Region
                                    {
                                        ID = Convert.ToInt32(reader["region1id"]),
                                        Name = reader["region1"].ToString()
                                    },
                                    Rank = Convert.ToInt32(reader["rank1Id"])
                                },
                                Tourny2 = new Tourny
                                {
                                    Id = Convert.ToInt32(reader["tourny2id"]),
                                    Team = new Team
                                    {
                                        ID = Convert.ToInt32(reader["team2id"]),
                                        Name = reader["team2name"].ToString()
                                    },
                                    Region = new Region
                                    {
                                        ID = Convert.ToInt32(reader["region2id"]),
                                        Name = reader["region2"].ToString()
                                    },
                                    Rank = Convert.ToInt32(reader["rank2Id"])
                                },
                                Winner = new Tourny
                                {
                                    Id = GetIntFromDb(reader["winnerId"]),
                                    Team = new Team
                                    {
                                        ID = GetIntFromDb(reader["winnerTeamId"]),
                                        Name = GetStringFromDb(reader["winnerName"])
                                    },
                                    Rank = GetIntFromDb(reader["rankWinnerId"])
                                },
                                roundId = GetIntFromDb(reader["roundId"])
                            });
                        }
                    }
                }
            }
            return currentMatchup;
        }

        public MatchUp GetMatchupById(int id)
        {
            MatchUp currentMatchup = new MatchUp();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetMatchupById", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@matchupId", id);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentMatchup = new MatchUp
                            {
                                ID = Convert.ToInt32(reader["id"]),
                                Tourny1 = new Tourny
                                {
                                    Id = Convert.ToInt32(reader["tourny1id"]),
                                    Team = new Team
                                    {
                                        ID = Convert.ToInt32(reader["team1id"]),
                                        Name = reader["team1name"].ToString()
                                    },
                                    Region = new Region
                                    {
                                        ID = Convert.ToInt32(reader["region1id"]),
                                        Name = reader["region1"].ToString()
                                    },
                                    Rank = Convert.ToInt32(reader["rank1Id"])
                                },
                                Tourny2 = new Tourny
                                {
                                    Id = Convert.ToInt32(reader["tourny2id"]),
                                    Team = new Team
                                    {
                                        ID = Convert.ToInt32(reader["team2id"]),
                                        Name = reader["team2name"].ToString()
                                    },
                                    Region = new Region
                                    {
                                        ID = Convert.ToInt32(reader["region2id"]),
                                        Name = reader["region2"].ToString()
                                    },
                                    Rank = Convert.ToInt32(reader["rank2Id"])
                                },
                                roundId = Convert.ToInt32(reader["roundId"])
                            };
                        }
                    }
                }
            }
            return currentMatchup;
        }

        public Team GetTeamById(int teamId)
        {
            Team team = new Team();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetTeamById", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@teamId", teamId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            team.ID = Convert.ToInt32(reader["id"]);
                            team.Name = reader["name"].ToString();
                        }
                    }
                }
            }
            return team;
        }

        public bool UpsertTeam(Team team)
        {
            int rows = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.UpsertTeam", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if(team.ID != null)
                        cmd.Parameters.AddWithValue("@ID", team.ID);
                    cmd.Parameters.AddWithValue("@name", team.Name);

                    rows = cmd.ExecuteNonQuery();
                }
            }
            return rows > 0;
        }

        public bool UpsertRegion(Region region)
        {
            int rows = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.UpsertRegion", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    //if(team.ID != null)
                    //cmd.Parameters.AddWithValue("@ID", team.ID);
                    cmd.Parameters.AddWithValue("@name", region.Name);

                    rows = cmd.ExecuteNonQuery();
                }
            }
            return rows > 0;
        }

        public bool UpsertRound(Round round)
        {
            int rows = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.UpsertRound", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    //if(team.ID != null)
                    //cmd.Parameters.AddWithValue("@ID", team.ID);
                    cmd.Parameters.AddWithValue("@round", round.Name);

                    rows = cmd.ExecuteNonQuery();
                }
            }
            return rows > 0;
        }

        public bool UpsertRank(Rank rank)
        {
            int rows = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.UpsertRank", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    //if(team.ID != null)
                    //cmd.Parameters.AddWithValue("@ID", team.ID);
                    cmd.Parameters.AddWithValue("@rank", rank.Name);

                    rows = cmd.ExecuteNonQuery();
                }
            }
            return rows > 0;
        }

        public List<User> GetCurrentUsers()
        {
            List<User> currentUsers = new List<User>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetCurrentUsers", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currentUsers.Add(new User
                            {
                                Username = reader["username"].ToString(),
                                ID = Convert.ToInt32(reader["ID"]),
                                Active = Convert.ToBoolean(reader["active"])
                            });
                        }
                    }
                }
            }
            return currentUsers;
        }

        public int ChooseWinners(int matchUpId, int winnerId)
        {
            int roundId = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.ChooseMatchUpWinner", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@matchUpID", matchUpId);
                    cmd.Parameters.AddWithValue("@winnerID", winnerId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            roundId = GetIntFromDb(reader["roundId"]);
                        }
                    }
                }
            }
            return roundId;
        }

        public bool CreateTourny(Tourny tourny)
        {
            //foreach (Tourny team in tourny)
            //{
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
                {
                    connection.Open();
                    using (SqlCommand cmd = new SqlCommand("dbo.CreateTourny", connection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@teamID", tourny.Team.ID);
                        cmd.Parameters.AddWithValue("@regionID", tourny.Region.ID);
                        cmd.Parameters.AddWithValue("@rankId", tourny.Rank);

                        cmd.ExecuteNonQuery();
                    }
                }
            //}
            return true;
        }

        public bool GenerateFirstRoundMatchups()
        {
            List<int> regionIds = new List<int>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetAllRegions", connection))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            regionIds.Add(Convert.ToInt32(reader["id"]));
                        }
                    }
                }
                foreach(int j in regionIds)
                {
                    for (int i = 1; i <= 8; i++)
                    {
                        using (SqlCommand cmd = new SqlCommand("dbo.GenerateFirstMatchup", connection))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@regionID", j);
                            cmd.Parameters.AddWithValue("@rank", i);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
            
            return true;
        }

        public bool CheckIfTeamExists(Team team)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.CheckTeamName", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@name", team.Name);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    }
                }
            }
        }

        public bool CheckPreviousRoundMatchups(string roundId)
        {
            int round;
            if (!int.TryParse(roundId, out round))
                return false;

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.CheckPreviousRound", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@roundId", round);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if(reader.Read())
                            return Convert.ToBoolean(reader["complete"]);
                    }
                }
            }
            return false;
        }

        public bool GenerateNextRoundMatchups(Round round)
        {
            double tempSeeds;
            int numOfSeeds;

            tempSeeds = 16 / (Math.Pow(2, round.Name - 1));

            if (!int.TryParse(tempSeeds.ToString(), out numOfSeeds))
                return false;

            List<int> regionIds = new List<int>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetAllRegions", connection))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            regionIds.Add(Convert.ToInt32(reader["id"]));
                        }
                    }
                }
                foreach (int j in regionIds)
                {
                    for (int i = 1; i <= numOfSeeds / 2; i++)
                    {
                        using (SqlCommand cmd = new SqlCommand("dbo.GenerateMatchup", connection))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@regionID", j);
                            cmd.Parameters.AddWithValue("@seed", i);
                            cmd.Parameters.AddWithValue("@numOfSeed", numOfSeeds);
                            cmd.Parameters.AddWithValue("@roundId", round.ID);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }

            return true;
        }

        public bool GenerateFinalFour(int roundId, int region1Id, int region2Id)
        {
            int rows = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GenerateFinalFour", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@region1", region1Id);
                    cmd.Parameters.AddWithValue("@region2", region2Id);
                    cmd.Parameters.AddWithValue("@roundId", roundId);

                    rows = cmd.ExecuteNonQuery();
                }
            }
            return rows > 0;
        }

        public bool GenerateFinal(int roundId)
        {
            int rows = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GenerateFinal", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@roundId", roundId);

                    rows = cmd.ExecuteNonQuery();
                }
            }
            return rows > 0;
        }

        public bool ActivateUser(int userId)
        {
            int rows = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.ActivateUser", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@userId", userId);

                    rows = cmd.ExecuteNonQuery();
                }
            }
            return rows > 0;
        }

        public bool IsItTimeToPlay()
        {
            bool itIsTime = false;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.IsItTimeToPlay", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while(reader.Read())
                            itIsTime = Convert.ToBoolean(reader[0]);
                    }
                }
            }
            return itIsTime;
        }

        public List<Tuple<DateTime,DateTime>> GetGamePlayTimes()
        {
            List<Tuple<DateTime, DateTime>> times = new List<Tuple<DateTime, DateTime>>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.GetTimesGamesArePlaying", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            times.Add(new Tuple<DateTime, DateTime>(
                                Convert.ToDateTime(reader["startTime"]),
                                Convert.ToDateTime(reader["endTime"])
                            ));
                        }
                    }
                }
            }
            return times;
        }

        public bool SetPlayTimes(DateTime startTime, DateTime endTime)
        {
            int rows = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.AddGameTimes", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@startTime", startTime);
                    cmd.Parameters.AddWithValue("@endTime", endTime);

                    rows = cmd.ExecuteNonQuery();
                }
            }
            return rows > 0;
        }

        public bool OverriedUserPassword(int userId, string password)
        {
            int rows = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["IYFD"].ToString()))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.OverriedUserPass", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@userId", userId);
                    cmd.Parameters.AddWithValue("@password", Encrypt(password));

                    rows = cmd.ExecuteNonQuery();
                }
            }
            return rows > 0;
        }

        #endregion

        #region Helpers

        private int GetIntFromDb(object readValue)
        {
            if (readValue == null || string.IsNullOrEmpty(readValue.ToString()))
                return 0;
            else
                return Convert.ToInt32(readValue);
        }

        private string GetStringFromDb(object readValue)
        {
            if (readValue == null || string.IsNullOrEmpty(readValue.ToString()))
                return string.Empty;
            else
                return readValue.ToString();
        }

        private string Encrypt(string wordToEncrypt)
        {
            byte[] bs = System.Text.Encoding.UTF8.GetBytes(wordToEncrypt);
            bs = _cryptographer.ComputeHash(bs);
            System.Text.StringBuilder encryptedWord = new System.Text.StringBuilder();
            foreach (byte b in bs)
            {
                encryptedWord.Append(b.ToString("x2").ToLower());
            }
            return encryptedWord.ToString();
        }

        #endregion
    }
}